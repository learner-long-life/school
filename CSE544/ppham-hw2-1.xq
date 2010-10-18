(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 1 - Retrieve all the names of all cities located in Peru,
sorted alphabetically.
:)

<result>
{
  let $root := document("mondial-3.0.xml")/mondial
  for $city-name in $root/country[data(@name) = 'Peru']//city/name/text()
    order by $city-name
    return 
     <city>{normalize-space($city-name)}</city>
}
</result>
