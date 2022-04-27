#!/bin/zsh

######### MODIFY YOUR DEVICES, THEIR IP ADDRESSES, AND USERNAMES HERE #########

devices=(351v 351p)

declare -A hosts
hosts[351v]="192.168.4.199"
hosts[351p]="192.168.4.207"

declare -A usernames
usernames[351v]="root"
usernames[351p]="root"

consoles=(nes snes genesis nds gba gbc wonderswancolor psp gamegear)

######### END USER MODIFICATION SECTION #########


######### DON'T EDIT AFTER HERE #########

mydir=${0:a:h}

while getopts s:d:c: flag
do
    case "${flag}" in
        s) starting_device=${OPTARG};;
        d) destination_device=${OPTARG};;
        c) console=${OPTARG};;
    esac
done

mkdir -p $mydir/../working_dir/synchronize/$starting_device/$console/

if (($devices[(I)$starting_device])) && (($devices[(I)$destination_device]))
then
    if (($consoles[(I)$console]))
    then
        if read -q "choice?Press Y/y to synchronize $console save files from the $starting_device to the $destination_device - "
        then   
            echo "\nProcessing..."
        else
            echo "\nNext time, then"
            exit 1
        fi

        echo $console
        mkdir -p $mydir/../working_dir/synchronize/$starting_device/$console/
        mkdir -p $mydir/../working_dir/backup/$destination_device/$console/

        scp -p $usernames[$destination_device]@$hosts[$destination_device]:"/roms/$console/*.{sav,srm}" "$mydir/..//working_dir/backup/$destination_device/$console/"
        scp -p $usernames[$starting_device]@$hosts[$starting_device]:"/roms/$console/*.{sav,srm}" "$mydir/../working_dir/synchronize/$starting_device/$console/"
     
        scp -r $mydir/../working_dir/synchronize/$starting_device/$console/* $usernames[$destination_device]@$hosts[$destination_device]:"/roms/$console/"
    else 
        echo "Please select a valid console (-c) of (nes, snes, genesis, nds, gba, gbc, wonderswancolor, psp, gamegear)"
        exit 1
    fi
else
    echo "Please select a valid starting device and destination device from the following (351p, 351v)"
    exit 1
fi 

