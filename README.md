# zimbra-mail-recovery
A simple tool created using bash scripting, to perform recovery or restore Zimbra mail based on the data in the store [ `/opt/zimbra/store` ]

The idea of this tool is when you lost or not found mail in the user mailbox, but you can find the mail in the store directory with `.msg` format.

This tool will help you in recovering/restoring/injecting mail obtained in .msg format for a specific user or even all users registered on your Zimbra servers.

## Configuration

1. Clone this repos: `git clone https://github.com/leonyonz/zimbra-mail-recovery.git`
2. Open and adjust the script inside `restore.sh`
- If you want recovering all mail in your zimbra services

```
USERS=$(su - zimbra -c "zmprov -l gaa | sort")
```

- If you want recovering some mail with list

```
USERS=$(cat mail1)
```

- If you want recovering single mail only

```
USERS="domain@domain.com"
```

3. Im assuming you place the tools inside `/tmp` directory, if you not use `/tmp` please adjust this.

```
...
chmod -R 777 /tmp/temp-restore-$mailbox_id
su - zimbra -c "zmmailbox -z -m $ACCOUNT am /Recovery /tmp/temp-restore-$mailbox_id";
```

## Usage

Run this tools with `root` privileges. 

To use this tools, please run this:

```
chmod +x restore.sh
./restore.sh
```

*Tested by recovering 1000 user mailbox in my project.*

## Doc

![image](https://github.com/leonyonz/zimbra-mail-recovery/assets/42370275/bcf41029-1b03-4804-80e9-5b8c2780fad5)

![image](https://github.com/leonyonz/zimbra-mail-recovery/assets/42370275/b16565e8-7002-4f03-951a-ff4924d80a03)

![image](https://github.com/leonyonz/zimbra-mail-recovery/assets/42370275/2eed6b1e-4ce8-4b4e-a48e-b3ef69a43aa1)

