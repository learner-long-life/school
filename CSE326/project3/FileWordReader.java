import java.io.*;
import java.util.*;

// FileWordReader is a convenient class for reading in
// words from a file.

class FileWordReader {
  StreamTokenizer tok;

  public FileWordReader(String file) 
	throws FileNotFoundException,
		   IOException
  {
	tok = new StreamTokenizer
	  (new BufferedReader
	   (new InputStreamReader
		(new FileInputStream(file))));
	tok.eolIsSignificant(false);
	tok.lowerCaseMode(true);
	tok.wordChars('a','z');
	tok.wordChars('A','Z');
	String ws = " \t.,!;:-[].,;!?*+-=\\|/(){}\"[]><'";
	for (int i = 0; i < ws.length(); i++) {
	  tok.whitespaceChars(ws.charAt(i),
						  ws.charAt(i));
	}
  }

  public String nextWord() 
	throws IOException
  {
	int ttype = tok.nextToken();
	while (ttype != tok.TT_WORD
		   && ttype != tok.TT_EOF)
	  ttype = tok.nextToken();
	if (ttype == tok.TT_EOF)
	  return null;
	return tok.sval;
  }
};
