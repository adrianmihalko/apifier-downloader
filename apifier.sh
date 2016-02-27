#!/bin/bash

#remove our temp file
rm /tmp/ok.var

#Part 1 - run crawler and get detailsUrl
#change api URL to yours (the URL with /execute parameter)
OK=$(curl -s "https://api.apifier.com/v1/yxyxyxyxyxyxyxyxyxy/crawlers/Example_Alcatraz_Cruises/execute?token=yxyxyxyx" | jq -r '.detai$
echo $OK > /tmp/ok.var

if [ -f /tmp/ok.var ]
then
deturl=`cat /tmp/ok.var`

#Part 2
function loop ()
{
        STATUS=$(curl -s "$deturl" | jq -r '.status')
        echo "$STATUS"
}

until [[ $(loop) = "SUCCEEDED" ]]; do
loop
sleep 5
done
fi

#Part 3
#if crawl finished download results
echo "finished..downloading result:"
FINALRESULT=$(curl -s "$deturl" | jq -r '.resultsUrl')
#you can choose xml/csv/json as output
curl -s "$FINALRESULT/?format=xml" /var/www/result.xml
