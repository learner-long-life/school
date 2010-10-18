#! /bin/sh

set -x

java WordCount -b -frequency 'c:/ppham/school/CSE326/the-new-atlantis.txt' 2>&1 > atlantis-b.out
read
java WordCount -a -frequency "c:/ppham/school/CSE326/the-new-atlantis.txt" 2>&1 > atlantis-a.out
read
java WordCount -s -frequency "c:/ppham/school/CSE326/the-new-atlantis.txt" 2>&1 > atlantis-s.out
read
java WordCount -h -frequency "c:/ppham/school/CSE326/the-new-atlantis.txt" 2>&1 > atlantis-h.out
read
java WordCount -h -num_unique 'c:/ppham/school/CSE326/the-new-atlantis.txt' 2>&1 > atlantis-n.out
read

ls -lh *.out
read

java WordCount -b -frequency 'c:/ppham/school/CSE326/empty' 2>&1
read
java WordCount -a -frequency "c:/ppham/school/CSE326/empty" 2>&1
read
java WordCount -s -frequency "c:/ppham/school/CSE326/empty" 2>&1
read
java WordCount -h -frequency "c:/ppham/school/CSE326/empty" 2>&1
read
java WordCount -h -num_unique 'c:/ppham/school/CSE326/empty' 2>&1
read

ls -lh *.out
read

java WordCount -b -frequency 'c:/ppham/school/CSE326/words' 2>&1 > watlantis-b.out
read
java WordCount -a -frequency "c:/ppham/school/CSE326/words" 2>&1 > watlantis-a.out
read
java WordCount -s -frequency "c:/ppham/school/CSE326/words" 2>&1 > watlantis-s.out
read
java WordCount -h -frequency "c:/ppham/school/CSE326/words" 2>&1 > watlantis-h.out
read
java WordCount -h -num_unique 'c:/ppham/school/CSE326/words' 2>&1 > watlantis-n.out
read

ls -lh *.out
read

java Correlator -h 'c:/ppham/school/CSE326/hamlet.txt' 'c:/ppham/school/CSE326/othello.txt' > hamlet-othello.out
read
java Correlator -h 'c:/ppham/school/CSE326/hamlet.txt' 'c:/ppham/school/CSE326/the-new-atlantis.txt' > hamlet-atlantis.out
read
java Correlator -h 'c:/ppham/school/CSE326/othello.txt' 'c:/ppham/school/CSE326/the-new-atlantis.txt' > othello-atlantis.out
read
java Correlator -h 'c:/ppham/school/CSE326/othello.txt' 'c:/ppham/school/CSE326/learning.txt' > othello-learning.out
read
java Correlator -h 'c:/ppham/school/CSE326/hamlet.txt' 'c:/ppham/school/CSE326/learning.txt' > hamlet-learning.out
read
java Correlator -h 'c:/ppham/school/CSE326/the-new-atlantis.txt' 'c:/ppham/school/CSE326/learning.txt' > atlantis-learning.out
read

echo "Hamlet-Othello" >> correlate.out
cat hamlet-othello.out >> correlate.out
echo "Hamlet-Atlantis" >> correlate.out
cat hamlet-atlantis.out >> correlate.out
echo "Othello-Atlantis" >> correlate.out
cat othello-atlantis.out >> correlate.out
echo "Othello-Learning" >> correlate.out
cat othello-learning.out >> correlate.out
echo "Hamlet-Learning" >> correlate.out
cat hamlet-learning.out >> correlate.out
echo "Atlantis-Learning" >> correlate.out
cat atlantis-learning.out >> correlate.out

cat correlate.out

set +x