(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

   Problem 10 - For each river which crosses at least 2 countries,
   return its name, and the names of the countries it crosses. Order by
   the numbers of countries crossed.
:)

<user>
{
  let $root := document("mondial-3.0.xml")
  for $river in $root/mondial/river
    let $countries     := distinct-values($river/located/@country)
    let $country-count := count($countries)
    where $country-count >= 2
    order by $country-count
    return <river>
             <name>{data($river/@name)}</name>
             {for $country-id in $countries
               let $matches := $root/mondial/country[@id = $country-id]
               for $country-name in $matches/@name
                        return <country>{data($country-name)}</country>
                    
             }
           </river>
}
</user>
