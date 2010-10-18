(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

Problem 5 - Find the names of all countries that have at least 3
   mountains over 2000m high, and list the names and heights of all
   mountains in these countries (regardless of their height)
:)

<result>
{
let $root := document("mondial-3.0.xml")
for $x in $root/mondial/country
  let $high-mountain-count :=
      count($root/mondial/mountain[located/@country = $x/@id and
                                   @height > 2000])
  where $high-mountain-count >= 3
    return
      for $mountain in $root/mondial/mountain[located/@country = $x/@id]
        return <mountains>
                 {$mountain/@height}
                 <name>{normalize-space($mountain/@name)}</name>
               </mountains>
}
</result>
