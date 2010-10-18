(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 9 - Find all the provinces(states) of the United States
   with population more than 11,000,000. Compute the ratio of each
   qualified state's population to the whole population of the
   country. Return each state's name and the ratio. Order by the ratio in
   descending order.
:)

<result>
{
  let $root    := document("mondial-3.0.xml")/mondial
  let $us      := $root/country[@name='United States']
  let $total   := sum($us/province/@population)
  let $matches := $us/province[@population > 11000000]
  for $x in $matches
    let $ratio := $x/@population div $total
    order by $ratio descending
    return
      <state>
        <name>{data($x/@name)}</name>
        <ratio>{$ratio}</ratio>
      </state>
}
</result>
