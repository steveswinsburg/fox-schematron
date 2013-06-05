fox-schematron
==============

Schematron config for developing FOXopen in Oxygen

### Fox Module Validation

* Create a new project
* Add the FOX module directory of your choosing to your project
* Right click the directory in your project and select Validate->Configure validation scenario 
* Click "new"
* Add both the fox_schema.xsd and fox_schema.sch to the validation scenario, using the versions in the schematron project checked out earlier. Select the "schematron" schema-type for the fox_schema.sch schema.

You need to convert your FOX modules to work with these new schema to ensure all the namespaces are linked to unique URIs. The recommended way is to append the namespace to the end of the URI e.g. xmlns:edit="http: //www.og.dti.gov/fox" -> xmlns:edit="http: //www.og.dti.gov/fox/edit".

There exists a perl script located in the new schema folders which tries to convert from the old style namespaces to the new one and vice-versa. The script does create a backup before any action is taken, but it may be worth creating your own especially when converting your changes back to the old style for check-in. 
