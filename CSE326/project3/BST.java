
// A naive unbalanced Binary Search Tree that
// implements StringCounter

public class BST implements StringCounter {
  BST() {
	root = null;
	size = 0;
  }

  public void IncCount(String s) {
	if (root == null) {
	  root = new BSTNode(s);
	} else {
	  BSTNode n = root;
	  while (true) {
		int cmp = n.str.compareTo(s);
		if (cmp == 0) { // match
		  n.cnt++;
		  return;
		} else if (cmp > 0) { // go left, young man!
		  if (n.left == null) {
			n.left = new BSTNode(s);
			return;
		  }
		  n = n.left;
		} else { // go right!
		  if (n.right == null) {
			n.right = new BSTNode(s);
			return;
		  }
		  n = n.right;
		}
	  }
	}
  }

  public int GetSize() {
    return size;
  }

  public StringCount[] GetCounts() {
	StringCount[] data = new StringCount[size];
	if (root != null)
	  root.Traverse(data, 0);
	return data;
  }
  
  BSTNode root;
  int size;

  String Dump() {
	if (root != null)
	  return root.Dump();
	return "<null tree>";
  }

  public class BSTNode {
	BSTNode left, right;
	String str;
	int cnt;

	BSTNode(String s) {
	  str = s;
	  cnt = 1;
	  left = right = null;
	  size++;  // note use of inner class
	}

	int Traverse(StringCount[] data, int idx) {
	  if (left != null)
		idx = left.Traverse(data, idx);
	  data[idx++] = new StringCount(str, cnt);
	  if (right != null)
		idx = right.Traverse(data, idx);
	  return idx;
	}

	String Dump() {
	  String out = "(["+str+","+cnt+"] ";
	  if (left != null)
		out += left.Dump();
	  else out += ".";
	  out += " ";
	  if (right != null)
		out +=  right.Dump();
	  else out += ".";
	  out += ")";
	  return out;
	}
  }

  static public void main(String[] args) {
	boolean dumpall = false, notest = false;;
	
	if (args.length > 1
		|| (args.length == 1
			&& args[0].compareTo("dump") != 0
			&& args[0].compareTo("notest") != 0)) {
	  System.err.println("Arguments: [dump] to dump all output");
	  System.err.println("           [notest] to skip tests");
	  System.err.println("No arguments justs tests output");
	  return;
	}

	if (args.length == 1) {
	  dumpall = true;
	  if (args[0].compareTo("notest") == 0)
		notest = true;
	}

	String[][] tests = 
	  {{ "g", "h", "a", "b", "a", "h", "j", "e", "e", "f" },
	   { "5", "3", "1", "2", "7", "6", "0", "8", "9", "4",
		 "3", "5", "0", "9" },
           {}};

	String[][] expected = {
	  {
		"([g,1] . .)",
		"([g,1] . ([h,1] . .))",
		"([g,1] ([a,1] . .) ([h,1] . .))",
		"([g,1] ([a,1] . ([b,1] . .)) ([h,1] . .))",
		"([g,1] ([a,2] . ([b,1] . .)) ([h,1] . .))",
		"([g,1] ([a,2] . ([b,1] . .)) ([h,2] . .))",
		"([g,1] ([a,2] . ([b,1] . .)) ([h,2] . ([j,1] . .)))",
		"([g,1] ([a,2] . ([b,1] . ([e,1] . .))) ([h,2] . ([j,1] . .)))",
		"([g,1] ([a,2] . ([b,1] . ([e,2] . .))) ([h,2] . ([j,1] . .)))",
		"([g,1] ([a,2] . ([b,1] . ([e,2] . ([f,1] . .)))) ([h,2] . ([j,1] . .)))",
		"a,2 b,1 e,2 f,1 g,1 h,2 j,1 "
	  },
	  {
		"([5,1] . .)",
		"([5,1] ([3,1] . .) .)",
		"([5,1] ([3,1] ([1,1] . .) .) .)",
		"([5,1] ([3,1] ([1,1] . ([2,1] . .)) .) .)",
		"([5,1] ([3,1] ([1,1] . ([2,1] . .)) .) ([7,1] . .))",
		"([5,1] ([3,1] ([1,1] . ([2,1] . .)) .) ([7,1] ([6,1] . .) .))",
		"([5,1] ([3,1] ([1,1] ([0,1] . .) ([2,1] . .)) .) ([7,1] ([6,1] . .) .))",
		"([5,1] ([3,1] ([1,1] ([0,1] . .) ([2,1] . .)) .) ([7,1] ([6,1] . .) ([8,1] . .)))",
		"([5,1] ([3,1] ([1,1] ([0,1] . .) ([2,1] . .)) .) ([7,1] ([6,1] . .) ([8,1] . ([9,1] . .))))",
		"([5,1] ([3,1] ([1,1] ([0,1] . .) ([2,1] . .)) ([4,1] . .)) ([7,1] ([6,1] . .) ([8,1] . ([9,1] . .))))",
		"([5,1] ([3,2] ([1,1] ([0,1] . .) ([2,1] . .)) ([4,1] . .)) ([7,1] ([6,1] . .) ([8,1] . ([9,1] . .))))",
		"([5,2] ([3,2] ([1,1] ([0,1] . .) ([2,1] . .)) ([4,1] . .)) ([7,1] ([6,1] . .) ([8,1] . ([9,1] . .))))",
		"([5,2] ([3,2] ([1,1] ([0,2] . .) ([2,1] . .)) ([4,1] . .)) ([7,1] ([6,1] . .) ([8,1] . ([9,1] . .))))",
		"([5,2] ([3,2] ([1,1] ([0,2] . .) ([2,1] . .)) ([4,1] . .)) ([7,1] ([6,1] . .) ([8,1] . ([9,2] . .))))",
		"0,2 1,1 2,1 3,2 4,1 5,2 6,1 7,1 8,1 9,2 "
	  },
          {
                "<null tree>",
                "No Data"
          }
	};


	boolean error = false;
	for (int i = 0; i < tests.length; i++) {
	  BST T = new BST();
	  for (int j = 0; j < tests[i].length; j++) {
		T.IncCount(tests[i][j]);
		String out = T.Dump();
		if (notest
			|| out.compareTo(expected[i][j]) != 0)
		  error = true;
		if (dumpall)
		  System.out.println(out);
	  }
          if (tests[i].length < 1) {
                String out = T.Dump();
                if (notest
                        || out.compareTo(expected[i][0]) != 0)
                  error = true;
                if (dumpall)
                  System.out.println(out);
          }             
	  StringCount[] cnt = T.GetCounts();
	  String out = "";
	  if (cnt != null && cnt.length > 0)
                for (int j = 0; j < cnt.length; j++)
		    out += cnt[j].str+","+cnt[j].cnt+" ";
          else
                out = "No Data";
	  if (notest
		  || out.compareTo(expected[i][expected[i].length-1]) != 0)
		error = true;
	  if (dumpall)
		System.out.println(out);
	}

	if (!notest) {
	  if (error)
		System.out.println("Test failed!");
	  else
		System.out.println("Test passed");
	}
  }
}
