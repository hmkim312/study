import socket

HOST = 'localhost'
PORT = 9009

def getfilefromserver(filename):
    data_trasferred = 0
    
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.connect((HOST, PORT))
        sock.sendall(filename.encode())
        
        data = sock.recv(1024)
        if not data :
            print(f'{filename} : 서버에 존재하지 않거나 전송중 오류 발생')
            return
        
        with open('download/' + filename, 'wb') as f:
            try:
                while data:
                    f.write(data)
                    data_trasferred += len(data)
                    data = sock.recv(1024)
            except Exception as e:
                print(e)
                
    print(f'파일[{filename} 전송종료, 전송량[{data_trasferred}]]')

filename = input('다운로드 받을 파일 이름을 입력하세요 :')
getfilefromserver(filename)