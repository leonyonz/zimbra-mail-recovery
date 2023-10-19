#!/bin/bash

clear

echo "Retrieve all zimbra user name..."

USERS=$(su - zimbra -c "zmprov -l gaa | sort")
#USERS=$(cat mail1)
#USERS="domain@domain.com"

for ACCOUNT in $USERS; do
    echo "Find Mail Range 15-18 October 2023 $ACCOUNT mailbox..."
    mailbox_id=$(su - zimbra -c "zmprov getMailboxInfo $ACCOUNT"|grep mailboxId| awk '{print $2}')
    dir_num=$(ls -1 /opt/zimbra/store/0/$mailbox_id/msg/|sort -rn)
    for num in $dir_num; do
        printf "Dir position at $num...\n"
        backup_dir=/opt/zimbra/store/0/$mailbox_id/msg/$num
        # Adjust 1[5678] bellow with specific date range, in the example it will generate range 15,16,17,18
        # other example 2[123] will generate range 21,22,23
        grep "^Date: [a-zA-Z]*, 1[5678] Oct 2023" $backup_dir/* -l > list-$mailbox_id.txt
        mkdir temp-restore-$mailbox_id
        for mf in `cat list-$mailbox_id.txt`; do
            cp -v $mf temp-restore-$mailbox_id
        done
        printf "Restore mail range 15-18 October 2023 $ACCOUNT mailbox-id $mailbox_id...\n"
        ## Assuming this script placed in /tmp, maybe you will need to adjust this if you used other places.
        chmod -R 777 /tmp/temp-restore-$mailbox_id
        su - zimbra -c "zmmailbox -z -m $ACCOUNT am /Inbox /tmp/temp-restore-$mailbox_id";
        rm -rfv temp-restore-$mailbox_id/*
    done
done

printf "\n"
echo "All mailbox has been restored sucessfully"
