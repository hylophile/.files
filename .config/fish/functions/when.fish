function when
    curl -s https://www.episodate.com/api/show-details?q=$argv[1] | jq -r '.tvShow.episodes .[] | "\\(.air_date)   S\\(if .season < 10 then "0" + (.season | tostring) else .season | tostring end)E\\(if .episode < 10 then "0" + (.episode | tostring) else .episode | tostring end)   \\(.name)"'
end
