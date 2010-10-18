(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 4 - Find all countries adjacent to the Pacific Ocean.
:)

<result>
{
  let $root := document("mondial-3.0.xml")/mondial
  let $matches := $root/sea[@name='Pacific Ocean']/located/@country
  for $x in distinct-values($matches)
    return
      for $y in $root/country[@id = $x]
        return <countries>{normalize-space($y/name/text())}</countries>
}
</result>
