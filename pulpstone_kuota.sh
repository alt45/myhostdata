#!/bin/sh
pulpstone_general=17-03-2018
case $1 in  
"paket3")
 	imei='866066042981591'
	loginurl='http://bimaplus.tri.co.id/api/v1/login/auto-login'
	profileurl='http://bimaplus.tri.co.id/api/v1/profile/profile'
	logined='{"imei":"'$imei'","msisdn":null,"deviceModel":null,"deviceManufactur":null,"deviceOs":null}' 
	login=$(curl -X POST -H "Content-Type: application/json" -d "$logined" "$loginurl" | sed -e "s/null/\"Kosong\"/g") &> /dev/null
	msisdn=$(jsonfilter -s "$login"  -e "$.msisdn")
	secretKey=$(jsonfilter -s "$login"  -e "$.secretKey")
	subscriberType=$(jsonfilter -s "$login"  -e "$.subscriberType")
	profiled='{"msisdn":"'$msisdn'","imei":null,"secretKey":"'$secretKey'","language":0,"subscriberType":"'$subscriberType'","callPlan":null}'
	profiles=$(curl -X POST -H "Content-Type: application/json" -d "$profiled" "$profileurl" | sed -e "s/null/\"Kosong\"/g")&> /dev/null
	balanceTotal=$(jsonfilter -s "$profiles"  -e "$.balanceTotal")
	dukcapilName=$(jsonfilter -s "$profiles"  -e "$.dukcapilName")
	callPlan=$(jsonfilter -s "$profiles"  -e "$.callPlan")
	paketname=$(jsonfilter -s "$profiles"  -e "$.packageList[*].name")
	validity=$(jsonfilter -s "$profiles"  -e "$.packageList[*].detail[*].validity")
	valuepaket=$(jsonfilter -s "$profiles"  -e "$.packageList[*].detail[*].value")
	echo -e "NamaReg : "$dukcapilName
	echo -e "Pulsa : "$balanceTotal
	echo -e "Paket : "$paketname
	echo -e "Jumlah : "$valuepaket
	echo -e "MasaAktif : "$validity
	echo -e "kodeAktif : "$secretKey
  ;;



  *)
    echo -e "Suported Operator:\nThree \kuota3"
;;
esac


