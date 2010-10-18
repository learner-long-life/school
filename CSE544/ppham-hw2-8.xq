(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 8 - For each province(state) in the United States, compute
   the ratio of its population to area, and return each province's name,
   its computed ratio, and order them by ratio. 
:)

<result>
{
  let $root := document("mondial-3.0.xml")/mondial
for $x in $root/country[@name='United States']/province
    let $ratio := $x/@population div $x/@area
    order by $ratio
    return
      <state>
        <name>{data($x/@name)}</name>
        <ratio>{$ratio}</ratio>
      </state>
}
</result>
