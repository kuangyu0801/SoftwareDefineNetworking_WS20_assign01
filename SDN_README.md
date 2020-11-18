


# Task1.1

# Task1.2

# Task1.3

# Task1.4

# 如何連到機器（簡單）

0 只需要做一次) 
用sshfs把自己本機的公鑰放到ipvslogin的遠端server裡面
```
sshfs liku@ipvslogin.informatik.uni-stuttgart.de:\home\liku remote_sshfs
```

1. 不用連到informatik也可以
```
ssh liku@ipvslogin.informatik.uni-stuttgart.de
```
接著輸入系統要求的密碼

2. 從ipvslogin跳到sdnfp04.infra.informatik.uni-stuttgart.de

```
ssh -i #your_public_key student@sdnfp04
```

3. 成功使用公鑰登入！
成功授權的公鑰是放在authorized_key這個檔案裡面，打開就可以檢視
```
vim .ssh/authorized_key
```

# 一勞永逸、一通百通

新增公鑰讓連到ipvs機器以後都不需要密碼
```
ssh-copy-id liku@ipvslogin.informatik.uni-stuttgart.de
```

接著系統會要求你輸入ipvs密碼，連進去之後就直接會是sdnfp04

新增.ssh/config讓ssh可以透過ipvslogin當作proxy直接連到sdnfp04
```
Host sdnfp04_proxy
        HostName sdnfp04
        User student
        ForwardAgent yes
        ForwardX11 yes
        ProxyJump proxy
Host proxy
        HostName ipvslogin.informatik.uni-stuttgart.de
        User liku
        ForwardAgent yes
        ForwardX11 yes
```
在.ssh/下執行ssh，直接登入，
```
ssh sdnfp04_proxy
```
mount遠端硬碟設定
```
sshfs sdnfp04_proxy:/home/student/ex1 remote_sshfs_ex1
```
不需要使用的時候
```
unmount remote_sshfs_ex1
```

# Open Issue
- 必須透過代理連到sdnfp04, 如何直接sshfs將遠端硬碟mount上來
- [https://www.ssh.com/ssh/config/][2] 
- LAN vs. VLAN
- ~~waiting for password to access VM~~

- 你該知道所有關於 SSH 的那些事 [https://jennycodes.me/posts/security-ssh][1]

[1]: https://jennycodes.me/posts/security-ssh
[2]: https://www.ssh.com/ssh/config/