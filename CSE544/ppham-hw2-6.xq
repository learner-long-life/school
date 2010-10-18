(:
Paul Pham [ppham@cs.washington.edu]
CSE 544: Principles of Database Systems
Spring 2006
Homework 2

 Problem 6 - One user is interested in long rivers. Produce the
   following view of the data, containing only rivers longer than 2000
   (all units are in km), in the format described below:

    * The root element is user and contains several river elements
    * Each river contains a name element with the river's name, and several
      country elements, one for each country through which it flows.
      (Note: some rivers may not have any country, due to noise in the data.
      It is OK to include these rivers, even if they look as they flow through
      no country at all.)
    * Each country element contains only the name of the country (a string).
:)

<user>
{
  let $root := document("mondial-3.0.xml")
  for $river in $root/mondial/river[@length > 2000]
    return <river>
             <name>{data($river/@name)}</name>
             {for $country-id in distinct-values($river/located/@country)
                for $country in $root/mondial/country[@id = $country-id]
                      return <country>{data($country/@name)}</country>
             }
           </river>
}
</user>
