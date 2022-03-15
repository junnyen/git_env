#encoding=utf-8
import telnetlib
import random, string
import time

def do_telnet(Host, Port, username, password):
    #連線Telnet伺服器
    tn = telnetlib.Telnet(Host, Port, timeout=1)
    # tn.set_debuglevel(1)
    
    #輸入登入使用者名稱
    tn.read_until(b"login: ")
    tn.write(username.encode('utf-8')+b'\r\n')
    
    # 輸入登入密碼
    tn.read_until(b"Password: ")
    tn.write(password.encode('utf-8')+b'\r\n')
    
    # 判斷密碼錯誤提示，如果沒有這個提示說明登入成功
    if tn.read_until(b"login: "):
        print("****** login incorrect!\n")
    tn.close
    
if __name__=='__main__':
    Host = "192.168.127.253"           # Telnet伺服器IP
    Port = 23        # Telnet伺服器埠
    username = "admin"
    i = 0
    print("[*] begin","\n")
    start = time.time()
    while True:
        if i == 5:
            print("Elapsed timestamp: ", time.time() - start)
            break;
        username = username + str(i+1)
        password = ''.join(random.choice(string.ascii_letters + string.digits) for x in range(10))
        print ("[*]Round",i+1,":",username,":",password,"")
        do_telnet(Host, Port, username, password)
        username = "admin"
        i = i+1
