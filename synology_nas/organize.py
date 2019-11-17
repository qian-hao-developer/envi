import sys, getopt, os, re, shutil, imp, datetime
from enum import Enum
from tqdm import tqdm

DEBUG = False

COLLECTION_ROOT = "/volume1/collection"
COMIC_ROOT = COLLECTION_ROOT + "/comic"
COMIC_DATA = ".."
COMIC_BACKUP = os.path.join(COMIC_DATA, "backup")
COMIC_LOG = os.path.join(COMIC_DATA, "log")

list_file = []

class STATUS(Enum):
    INIT = 1
    RECOGNIZED = 2
    UNRECOGNIZED = 3
    ERR = 4

class FILE:
    file_name = ""
    file_path = ""
    author = ""
    status = STATUS.INIT
    def __init__(self, file_name, file_path):
        self.file_name = file_name
        self.file_path = file_path
    def out(self):
        print("file_name : %s" % self.file_name)
        print("file_path : %s" % self.file_path)
        print("author : %s" % self.author)
        print("status : %s" % self.status)

def check_lib(target):
    try:
        imp.find_module(target)
        return True
    except ImportError:
        return False

def update_dirs():
    global COMIC_ROOT
    dir = [d for d in os.listdir(COMIC_ROOT) if os.path.isdir(os.path.join(COMIC_ROOT, d))]
    for d in dir:
        print(d)
    return dir

def prepare_file_info():
    global COMIC_ROOT
    if not os.path.isdir(COMIC_ROOT):
        print("[ERROR]: root path not exist, path = %s" % COMIC_ROOT)
        print("[ERROR]: exit")
        sys.exit(1)
    reg = 0
    unreg = 0
    file_list = [f for f in os.listdir(COMIC_ROOT) if os.path.isfile(os.path.join(COMIC_ROOT, f))]
    for f in file_list:
        ff = FILE(f, "%s/%s" % (COMIC_ROOT, f))
        m = re.search(r'\[([^\[]*)\]', f)
        if m:
            ff.author = m.group(1)
            ff.status = STATUS.RECOGNIZED
            list_file.append(ff)
            reg = reg + 1
        else:
            ff.status = STATUS.UNRECOGNIZED
            list_file.append(ff)
            unreg = unreg + 1
            continue
    print("###### unrecognized files:")
    outnone = True
    for i in list_file:
        if i.status != STATUS.UNRECOGNIZED:
            continue
        print(i.file_name)
        if outnone:
            outnone = False
    if outnone:
        print("NONE")
    print("######")
    return reg, unreg

def run(dry):
    global DEBUG, COMIC_ROOT, COMIC_BACKUP
    def append_status(org, str):
        if not org:
            org += str
        else:
            org += ",%s" % str
        return org
    if not check_lib("tqdm"):
        print("[ERROR]: tqdm library not installed, prepare it using pip")
        print("[ERROR]: exit")
        sys.exit(1)
    if DEBUG:
        print("[DEBUG]: dry = %s" % dry)
    reg, unreg = prepare_file_info()
    if reg == 0:
        print("[INFO]: no recognized file, over")
        return
    print("================== %sRUN ==================" % ("DRY " if dry else ""))
    os.makedirs(os.path.join(COMIC_ROOT, COMIC_LOG), exist_ok=True)
    log_file_name = "log_comic_%s_%s.txt" % (datetime.datetime.now().strftime('%Y%m%d'), datetime.datetime.now().strftime('%H%M%S'))
    log_file = os.path.join(COMIC_ROOT, COMIC_LOG, log_file_name)
    with open(log_file, 'w') as f:
        f.write("total: %s\n" % len(list_file))
        f.write("recognized: %s\n" % reg)
        f.write("unrecognized: %s\n" % unreg)
        f.write("==================")
        f.write('\n\n')
    bar = tqdm(total=len(list_file))
    for i in list_file:
        do_mkdir = False
        do_move = False
        backup_org = False
        backup_cur = False
        todo = "[@TODO_REPLACE@]: %s =====> " % i.file_name
        todo_replace = ""
        if i.status != STATUS.RECOGNIZED:
            bar.update(1)
            continue
        if not os.path.isdir(os.path.join(COMIC_ROOT, i.author)):
            todo_replace += "DIR"
            do_mkdir = True
        if os.path.isfile(os.path.join(COMIC_ROOT, i.author, i.file_name)):
            org_file_size = os.path.getsize(os.path.join(COMIC_ROOT, i.author, i.file_name))
            cur_file_size = os.path.getsize(os.path.join(COMIC_ROOT, i.file_name))
            if cur_file_size > org_file_size:
                todo_replace = append_status(todo_replace, "OVERRIDE")
                backup_org = True
                do_move = True
            else:
                todo_replace = append_status(todo_replace, "SKIP")
                backup_cur = True
        else:
            todo_replace = append_status(todo_replace, "FILE")
            do_move = True
        if do_move:
            todo += i.author
        msg = re.sub('@TODO_REPLACE@', todo_replace, todo)
        with open(log_file, 'a') as f:
            f.write(msg)
            f.write('\n')
        bar.clear()
        print(msg)
        bar.display()
        if backup_org and backup_cur:
            print("[ERROR]: backup for both cur and org, should never be")
            print("[ERROR]: stop with error")
            break
        if backup_org and (not os.path.isfile(os.path.join(COMIC_ROOT, i.author, i.file_name))):
            print("[ERROR]: backup for org planned, but no such file exist")
            print("[ERROR]: stop with error")
            break
        if backup_cur and do_move:
            print("[ERROR]: backup_cur and do_move both true, illegal")
            print("[ERROR]: stop with error")
            break
        if dry:
            bar.update(1)
            continue
        if DEBUG:
            print("[DEBUG]: do work")
        if do_mkdir:
            if DEBUG:
                print("[DEBUG]: do mkdir")
            os.makedirs(os.path.join(COMIC_ROOT, i.author), exist_ok=False)
        if backup_org or backup_cur:
            if DEBUG:
                print("[DEBUG]: do backup")
            os.makedirs(os.path.join(COMIC_ROOT, COMIC_BACKUP), exist_ok=True)
            if backup_cur:
                if DEBUG:
                    print("[DEBUG]: backup cur")
                shutil.move(os.path.join(COMIC_ROOT, i.file_name), os.path.join(COMIC_ROOT, COMIC_BACKUP, i.file_name))
            elif backup_org:
                if DEBUG:
                    print("[DEBUG]: backup org")
                shutil.copy(os.path.join(COMIC_ROOT, i.author, i.file_name), os.path.join(COMIC_ROOT, COMIC_BACKUP, i.file_name))
        if do_move:
            if DEBUG:
                print("[DEBUG]: do move")
            shutil.move(os.path.join(COMIC_ROOT, i.file_name), os.path.join(COMIC_ROOT, i.author, i.file_name))
        bar.update(1)
    bar.clear()
    print("================== OVER ==================")
    bar.display()

def usage():
    print("Usage: %s [-v|-p|-d|-r|-h] [--verbose|--path|--dry|--run|--help]" % sys.argv[0])
    print("     -v, --verbose: enable DEBUG log, use this together with other options")
    print("     -p, --path: root path, need input variable")
    print("     -d, --dry: dry run")
    print("     -r, --run: run organization for files")
    print("     -h, --help: show this message")

def test():
    print("[TEST]: this is test module")
    import time
    test = tqdm(total=100)
    for i in range(5):
        # test.clear()
        # print("test")
        # test.display()
        # test.clear()
        # print("test2")
        # test.display()
        print("test2")
        test.display(msg="test")
        test.update(1)
        time.sleep(1)
    test.clear()
    time.sleep(1)
    test.display()
    # for i in tqdm(range(5)):
    #     print("test")
    #     time.sleep(1)

def main():
    global DEBUG, COMIC_ROOT
    try:
        opts, args = getopt.getopt(sys.argv[1:], 'vp:drht', ['verbose', 'path=', 'dry', 'run', 'help', 'test'])
    except getopt.GetoptError as err:
        print(err)
        usage()
        sys.exit(2)
    for opt_name, opt_value in opts:
        if opt_name in ('-v', '--verbose'):
            DEBUG = True
        elif opt_name in ('-p', '--path'):
            COMIC_ROOT = opt_value
            if DEBUG:
                print("[DEBUG]: ROOT_PATH = %s" % COMIC_ROOT)
        elif opt_name in ('-d', '--dry'):
            run(True)
            sys.exit()
        elif opt_name in ('-r', '--run'):
            run(False)
            sys.exit()
        elif opt_name in ('-h', '--help'):
            usage()
            sys.exit()
        elif opt_name in ('-t', '--test'):
            test()
            sys.exit()
        else:
            assert False, "unhandled option"

if __name__ == "__main__":
    main()