cat $1 | sed -e 's/,/\t/g' | sed -e 's/(//g' | sed -e 's/)//g' | sed -e 's/\xB0//g' | sed -e 's/dB//g' | sed -e 's/\t/ /g'