#!/bin/bash
set -ex
# provide an arg file which contains id of wechat, each per line.
for i in $( cat args); do
  echo $i
  result=$(curl 'http://weixin.sogou.com/weixin?type=1&query='$i'&ie=utf8&_sug_=n&_sug_type_=' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://weixin.sogou.com/weixin?type=2&query=wzh&ie=utf8&_sug_=y&_sug_type_=&w=01019900&sut=19410&sst0=1463990726145&lkt=0%2C0%2C0' -H 'Cookie: GOTO=Af22194; SUV=00BF640E3B35D508572D5B7C9B78D962; ABTEST=0|1463989488|v1; IPLOC=CN1100; SUID=0520606E1E10930A000000005742B4F0; SUID=0520606E3108990A000000005742B4F0; weixinIndexVisited=1; SNUID=183D7D731E1B2E6080CF0E731E430CF4; JSESSIONID=aaaahw5Kg1sv-eXXq4htv; sct=3; LSTMV=724%2C72; LCLKINT=32525' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed | grep -m 1 'wx-rb bg-blue wx-rb_v1 _item' | egrep -o -e 'href="[^"]*' | cut -c 7- | sed -e 's/&amp;/\&/g')
  if [ -z "$result" ]; then
    exit
  else
    echo $i $result >>result.txt
    sed -i .bak -e 1d args
  fi
  sleep 5

done

