(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 2 - Find all countries with more than 20 provinces.
   I return country names here for your convenience,
   but to return the country elements, replace data($x/@name)
   with just $x.
:)

<result>
{ for $x in document("mondial-3.0.xml")/mondial/country
    where (count($x/child::province) > 20)
    return 
     <country>{data($x/@name)}</country>
}
</result>
