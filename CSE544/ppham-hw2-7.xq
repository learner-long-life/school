(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 7 - Return all the provincial capitals in China ordered by
   province name.
:)

<result>
{
for $x in document("mondial-3.0.xml")/mondial/country[@name='China']/province
    order by $x/@name
    return
      for $y in $x/child::city[@id = $x/@capital]/name
        return <capitals>{normalize-space($y/text())}</capitals>
}
</result>
