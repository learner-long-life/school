
//
// A class to use BST to count words.  You'll want to
// modify this to use extra flags to support different
// dictionary implementations.

public class WordCount {

  public static void countWords(String file) {
    StringCounter SC = new BST();

    try {
      String word;
      FileWordReader fwr = new FileWordReader(file);
      while((word=fwr.nextWord())!=null)
        SC.IncCount(word);
    } catch (Throwable error) {
      System.err.println
        ("Error processing "
         + file + error);
      System.exit(1);
    }

    // Use insertion sort to sort the BST by number of occurrences.
    // Note that we rely on GetCounts being sorted by name.  This
    // is an example of bad coupling!  Unfortunately that's what
    // you get using code from a "history professor".

    StringCount[] cnt = SC.GetCounts();
    if (cnt != null) {
      for (int i = 1; i < cnt.length; i++) {
        StringCount x = cnt[i];
        int j;
        for (j = i-1; j >= 0; j--) {
          if (cnt[j].cnt >= x.cnt)
            break;
          cnt[j+1] = cnt[j];
        }
        cnt[j+1] = x;
      }
      for (int i = 0; i < cnt.length; i++)
        System.out.println(cnt[i].cnt + " \t"
                           + cnt[i].str);
    } else
      System.out.println("No words found!");
  }

  public static void main(String[] args) {
    String filename = null;
    int i = 0;

    // Your program must check to see if we want to print out 
    // word frequencies or print the number of unique words.

    if (args.length != 1) {
      System.err.println("Usage: filename of document to analyze");
      System.exit(1);
    }

    countWords(args[0]);

  }
}
