(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 3 - Find all ethnic groups that live in more than 10 countries.
:)

<result>
{
  let $root := document("mondial-3.0.xml")/mondial
  for $x in distinct-values($root/country/ethnicgroups)
    let $ethnicname := normalize-space($x)
    let $matches    := $root/country/ethnicgroups[normalize-space(text())=
                                                  $ethnicname]
    let $country-count := count($matches)
    where $country-count > 10
      return
        <ethnicgroups>{$ethnicname}</ethnicgroups>
}
</result>
