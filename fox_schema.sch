<?xml version="1.0" encoding="UTF-8"?>
<!-- Schematron for Fox Modules. Reads attribute restrictions from fox.xsd and enforces them namespace-wide.-->
<!-- queryBinding="xslt2" must be included to support xpath 2.0 -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  
  <!-- namespace definitions -->
  <sch:ns uri="http://www.og.dti.gov/fox_module" prefix="fm"/>
  <sch:ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
  
  <!-- path to fox attributes document -->
  <sch:let name="fox-attrs-doc" value="document('./schema/fox.xsd')"/>
  
  <!-- attribute group node-sets within fox_attributes.xsd -->
  <sch:let name="set-out-attrs" value="$fox-attrs-doc/xs:schema/xs:attributeGroup[@name = 'zzz-set-out-attr-grp']/xs:attribute/@ref"/>
  <sch:let name="menu-out-attrs" value="$fox-attrs-doc/xs:schema/xs:attributeGroup[@name = 'zzz-set-menu-attr-group']/xs:attribute/@ref"/>
  <sch:let name="action-out-attrs" value="$fox-attrs-doc/xs:schema/xs:attributeGroup[@name = 'zzz-action-out-attr-grp']/xs:attribute/@ref"/>
  <sch:let name="action-attrs" value="$fox-attrs-doc/xs:schema/xs:attributeGroup[@name = 'zzz-action-out-attr-grp' or @name = 'zzz-action-attr-grp']/xs:attribute/@ref"/>
  <sch:let name="element-attrs" value="$fox-attrs-doc/xs:schema/xs:attributeGroup[@name = 'zzz-schema-element-attr-grp']/xs:attribute/@ref"/> 
  
  <!-- attribute node-set within fox attributes document -->
  <sch:let name="fox-attrs" value="$fox-attrs-doc/xs:schema/xs:attribute"/>
  
  <!-- asserts load of fox attributes document -->
  <sch:pattern id="document-load">  
    <sch:rule context="xs:schema">
      <sch:assert test="$fox-attrs-doc">
        Cannot load fox attributes document check location specified in fox_schema.sch 
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <!-- checks for attributes with illegal names in module -->
  <sch:pattern id="set-out-attrs">  
    <sch:rule context="fm:set-out/@*[not(local-name() = $set-out-attrs or namespace-uri() = '')]">
      <sch:report test="true()">
        Illegal attribute(s) present in set-out - <sch:name/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="menu-out-attrs">
    <sch:rule context="fm:menu-out/@*[not(local-name() = $menu-out-attrs or namespace-uri() = '')]">
      <sch:report test="true()">
        Illegal attribute(s) present in menu-out - <sch:name/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="action-out-attrs">
    <sch:rule context="fm:action-out/@*[not(local-name() = $action-out-attrs or namespace-uri() = '')]">
      <sch:report test="true()">
        Illegal attribute(s) present in action-out - <sch:name/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="action-attrs">
    <sch:rule context="fm:action/@*[not(local-name() = $action-attrs or namespace-uri() = '')]">
      <sch:report test="true()">
        Illegal attribute(s) present in action - <sch:name/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="element-attrs">
    <sch:rule context="xs:element/@*[not(local-name() = $element-attrs or namespace-uri() = '')]" >
      <sch:report test="true()">
        Illegal attribute(s) present in element - <sch:name/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern id="element-attrs-fm">
    <sch:rule context="xs:element/@*[namespace-uri() = 'http://www.og.dti.gov/fox_module']" >
      <sch:report test="true()">
        Use of the 'fm' namespace is not supported for schema attributes - <sch:name/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  
  <!-- checks for legal attributes with illegal types in module. -->
  <sch:pattern id="attr-types">
    <sch:rule context="@*[local-name() = $fox-attrs/@name and namespace-uri() != '']">
      
      <!-- current attribute and it's corresponding definition in fox attributes document -->
      <sch:let name="attr" value="."/>
      <sch:let name="fox-attr" value="$fox-attrs[@name = $attr/local-name()]"/>
      
      <!-- only basic xs datatypes currently supported, custom types must be redefined here -->
      <!-- xs:positiveInteger and xs:unsignedInt supported through oxygen, but not eclipse schematron plugin-->
      <!-- additional types have been hard-coded -->
      <sch:report test="$fox-attr/@type = 'xs:integer' and not(. castable as xs:integer)">
        Illegal value for <sch:name/> - <sch:value-of select="."/>, expecting <sch:value-of select="$fox-attr/@type"/>
      </sch:report>
      <sch:report test="$fox-attr/@type = 'xs:positiveInteger' and not(. castable as xs:integer and . > 0)">
        Illegal value for <sch:name/> - <sch:value-of select="."/>, expecting <sch:value-of select="$fox-attr/@type"/>
      </sch:report>
      <sch:report test="$fox-attr/@type = 'xs:unsignedInt' and not(. castable as xs:integer and . >= 0)">
        Illegal value for <sch:name/> - <sch:value-of select="."/>, expecting <sch:value-of select="$fox-attr/@type"/>
      </sch:report>
      <sch:report test="$fox-attr/@type = 'xs:boolean' and not(. castable as xs:boolean)">
        Illegal value for <sch:name/> - <sch:value-of select="."/>, expecting <sch:value-of select="$fox-attr/@type"/>
      </sch:report>
      <sch:report test="$fox-attr/@type = 'entered-string' and not(string-length() > 0)">
        Illegal value for <sch:name/> - <sch:value-of select="."/>, expecting <sch:value-of select="$fox-attr/@type"/>
      </sch:report>
      <sch:report test="$fox-attr/@type = 'yn-flag' and not(index-of(('','Y','N'), . ))">
        Illegal value for <sch:name/> - <sch:value-of select="."/>, expecting <sch:value-of select="$fox-attr/@type"/>
      </sch:report>
      
      <!-- crude enumeration checker, no support for extensions or restrictions -->
      <sch:report test="$fox-attr/xs:simpleType/xs:restriction/xs:enumeration and not(. = $fox-attr/xs:simpleType/xs:restriction/xs:enumeration/@value)">
        Illegal value for <sch:name/> - <sch:value-of select="."/>, expecting one of - <sch:value-of select="$fox-attr/xs:simpleType/xs:restriction/xs:enumeration/@value"/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  
</sch:schema>
