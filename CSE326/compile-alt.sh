#! /bin/sh

set -x

java WordCount -b 'c:\ppham\school\CSE326\the-new-atlantis.txt' > atlantis-b.out
java WordCount -a 'c:\ppham\school\CSE326\the-new-atlantis.txt' > atlantis-a.out
java WordCount -s 'c:\ppham\school\CSE326\the-new-atlantis.txt' > atlantis-s.out
java WordCount -h 'c:\ppham\school\CSE326\the-new-atlantis.txt' > atlantis-h.out
java WordCount -num_unique 'c:\ppham\school\CSE326\the-new-atlantis.txt' > atlantis-n.out

set +x