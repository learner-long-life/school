

// Simple wrapper class used below in StringCounter

class StringCount {
	String str;
	int cnt;
	StringCount(String s, int c) {
	  str = s; cnt = c;
	}
}


// Our "dictionary" interface
// Note that this is more specialized than a typical
// dictionary, since we only need ours to do fairly
// specific operations.  Note that this is a mapping
// from String to int.

public interface StringCounter
{

  // IncCount increments the count for a particular string
  void IncCount(String s);

  // GetSize returns the number of strings
  int GetSize();

  // GetCounts returns an array of all the string-count pairs
  // in the dictionary, sorted lexicographically by strings.
  // We've defined a StringCount container class
  // above to store the String-int pairs.
  StringCount[] GetCounts();

}
