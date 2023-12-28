function suggest
ls | sed -n (shuf -i1-(ls | wc -l) -n1)p
end
