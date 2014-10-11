<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:s="http://www.sbml.org/sbml/level2/version4"
  xmlns:cd="http://www.sbml.org/2001/ns/cd">
  
  <xsl:output method="text" encoding="UTF-8"/>
  
  <xsl:strip-space elements="s:sbml"/>
  <xsl:template match="/s:sbml/s:model">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a s:model ;&#10;</xsl:text>
    <xsl:text>  cd:metaid "</xsl:text><xsl:value-of select="@metaid" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:model_version "</xsl:text><xsl:value-of select="s:annotation/cd:extension/cd:modelVersion/." /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:model_display_size_x "</xsl:text><xsl:value-of select="s:annotation/cd:extension/cd:modelDisplay/@sizeX" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:model_display_size_y "</xsl:text><xsl:value-of select="s:annotation/cd:extension/cd:modelDisplay/@sizeY" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  .&#10;</xsl:text>
    <xsl:apply-templates select="s:annotation/cd:extension/cd:listOfIncludedSpecies/cd:species" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:listOfCompartmentAliases/cd:compartmentAlias" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:listOfComplexSpeciesAliases/cd:complexSpeciesAlias" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:listOfSpeciesAliases/cd:speciesAlias" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:listOfProteins/cd:protein" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:listOfCompartmentAliases/cd:compartmentAlias" />
    <xsl:apply-templates select="s:listOfUnitDefinitions/s:unitDefinition" />
    <xsl:apply-templates select="s:listOfCompartments/s:compartment" />
    <xsl:apply-templates select="s:listOfSpecies/s:species" />
    <xsl:apply-templates select="s:listOfReactions/s:reaction" />
  </xsl:template>
  
  <!-- START cd:species -->
  
  <xsl:template match="s:annotation/cd:extension/cd:listOfIncludedSpecies/cd:species">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a cd:species ;&#10;</xsl:text>
    <xsl:text>  cd:metaid "</xsl:text><xsl:value-of select="@id" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:name "</xsl:text><xsl:value-of select="@name" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:complexSpecies cd:</xsl:text><xsl:value-of select="cd:annotation/cd:complexSpecies" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:class cd:</xsl:text><xsl:value-of select="cd:annotation/cd:speciesIdentity/cd:class" /><xsl:text> ;&#10;</xsl:text>
    <xsl:apply-templates select="cd:annotation/cd:speciesIdentity/cd:name" />
    <xsl:apply-templates select="cd:annotation/cd:speciesIdentity/cd:proteinReference" />
    <xsl:apply-templates select="cd:annotation/cd:speciesIdentity/cd:state/cd:listOfModifications/cd:modification" />
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  <!-- cd:name IS OPTIONAL -->
  <xsl:template match="cd:annotation/cd:speciesIdentity/cd:name">
    <xsl:text>  cd:name "</xsl:text><xsl:value-of select="." /><xsl:text>" ;&#10;</xsl:text>
  </xsl:template>
  <!-- cd:proteinReference IS OPTIONAL -->
  <xsl:template match="cd:annotation/cd:speciesIdentity/cd:proteinReference">
    <xsl:text>  cd:proteinReference "</xsl:text><xsl:value-of select="." /><xsl:text>" ;&#10;</xsl:text>
  </xsl:template>
  <!-- cd:modification IS EMPTY NODE -->
  <xsl:template match="cd:annotation/cd:speciesIdentity/cd:state/cd:listOfModifications/cd:modification">
    <xsl:text>  cd:modification [&#10;</xsl:text>
    <xsl:text>    cd:residue "</xsl:text><xsl:value-of select="@residue" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>    cd:state "</xsl:text><xsl:value-of select="@state" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  ] ;&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   cd:species -->
  <!-- START cd:compartmentAlias -->
  
  <xsl:template match="cd:listOfCompartmentAliases/cd:compartmentAlias">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a cd:compartmentAlias ;&#10;</xsl:text>
    <xsl:text>  cd:compartment "</xsl:text><xsl:value-of select="@compartment" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:class "</xsl:text><xsl:value-of select="cd:class/." /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:point_x "</xsl:text><xsl:value-of select="cd:point/@x" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:point_y "</xsl:text><xsl:value-of select="cd:point/@y" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:name_point_x </xsl:text><xsl:value-of select="cd:namePoint/@x" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:name_point_y </xsl:text><xsl:value-of select="cd:namePoint/@y" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:double_line_thickness </xsl:text><xsl:value-of select="cd:doubleLine/@thickness" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:double_line_outerWidth </xsl:text><xsl:value-of select="cd:doubleLine/@outerWidth" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:double_line_innerWidth </xsl:text><xsl:value-of select="cd:doubleLine/@innerWidth" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:paint_color "</xsl:text><xsl:value-of select="cd:paint/@color" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:paint_scheme "</xsl:text><xsl:value-of select="cd:paint/@scheme" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:info_state "</xsl:text><xsl:value-of select="cd:info/@state" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:info_angle "</xsl:text><xsl:value-of select="cd:info/@angle" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:name_point_y </xsl:text><xsl:value-of select="cd:namePoint/@y" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   cd:compartmentAlias -->
  <!-- START cd:complexSpeciesAlias -->
  
  <xsl:template match="cd:listOfComplexSpeciesAliases/cd:complexSpeciesAlias">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a cd:complexSpeciesAlias ;&#10;</xsl:text>
    <xsl:text>  cd:species cd:</xsl:text><xsl:value-of select="@species" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:activity "</xsl:text><xsl:value-of select="cd:activity/." /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_x </xsl:text><xsl:value-of select="cd:bounds/@x" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_y </xsl:text><xsl:value-of select="cd:bounds/@y" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_w </xsl:text><xsl:value-of select="cd:bounds/@w" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_h </xsl:text><xsl:value-of select="cd:bounds/@h" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:font_size </xsl:text><xsl:value-of select="cd:font/@size" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:view_state "</xsl:text><xsl:value-of select="cd:view/@state" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:backupSize_w </xsl:text><xsl:value-of select="cd:backupSize/@w" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:backupView_state "</xsl:text><xsl:value-of select="cd:backupView/@state" /><xsl:text>" ;&#10;</xsl:text>
    <!-- cd:usualView -->
    <!-- cd:briefView -->
    <xsl:text>  cd:info_state "</xsl:text><xsl:value-of select="cd:info/@state" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:info_angle "</xsl:text><xsl:value-of select="cd:info/@angle" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   cd:complexSpeciesAlias -->
  <!-- START cd:speciesAlias -->
  
  <xsl:template match="cd:listOfSpeciesAliases/cd:speciesAlias">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a cd:speciesAlias ;&#10;</xsl:text>
    <xsl:text>  cd:species cd:</xsl:text><xsl:value-of select="@species" /><xsl:text> ;&#10;</xsl:text>
    <xsl:apply-templates select="@complexSpeciesAlias" />
    <xsl:text>  cd:activity "</xsl:text><xsl:value-of select="cd:activity/." /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_x </xsl:text><xsl:value-of select="cd:bounds/@x" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_y </xsl:text><xsl:value-of select="cd:bounds/@y" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_w </xsl:text><xsl:value-of select="cd:bounds/@w" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:bounds_h </xsl:text><xsl:value-of select="cd:bounds/@h" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:font_size </xsl:text><xsl:value-of select="cd:font/@size" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  cd:view_state "</xsl:text><xsl:value-of select="cd:view/@state" /><xsl:text>" ;&#10;</xsl:text>
    <!-- cd:usualView -->
    <!-- cd:briefView -->
    <xsl:text>  cd:info_state "</xsl:text><xsl:value-of select="cd:info/@state" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:info_angle "</xsl:text><xsl:value-of select="cd:info/@angle" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  <!-- cd:complexSpeciesAlias IS OPTIONAL -->
  <xsl:template match="@complexSpeciesAlias">
    <xsl:text>  cd:complexSpeciesAlias cd:</xsl:text><xsl:value-of select="." /><xsl:text> ;&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   cd:speciesAlias -->
  <!-- START cd:protein -->
  
  <xsl:template match="cd:listOfProteins/cd:protein">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a cd:protein ;&#10;</xsl:text>
    <xsl:text>  cd:name "</xsl:text><xsl:value-of select="@name" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:type "</xsl:text><xsl:value-of select="@type" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:apply-templates select="cd:listOfModificationResidues/cd:modificationResidue" />
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  <!-- cd:listOfModificationResidues IS A LIST -->
  <xsl:template match="cd:listOfModificationResidues/cd:modificationResidue">
    <xsl:text>  cd:modificationResidue [&#10;</xsl:text>
    <xsl:text>    cd:id "</xsl:text><xsl:value-of select="@id" /><xsl:text>" ;&#10;</xsl:text> <!-- THIS ID IS NOT UNIQUE! -->
    <xsl:text>    cd:name "</xsl:text><xsl:value-of select="@name" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>    cd:angle </xsl:text><xsl:value-of select="@angle" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>    cd:side "</xsl:text><xsl:value-of select="@side" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  ] ;&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   cd:protein -->
  <!-- START s:unitDefinition -->
  
  <xsl:template match="s:listOfUnitDefinitions/s:unitDefinition">
    <xsl:text>s:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a s:unitDefinition ;&#10;</xsl:text>
    <xsl:text>  s:metaid "</xsl:text><xsl:value-of select="@metaid" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  s:name "</xsl:text><xsl:value-of select="@name" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  .&#10;</xsl:text>
    <xsl:apply-templates select="s:listOfUnits/s:unit" />
  </xsl:template>
  <!-- s:listOfUnits IS A LIST -->
  <xsl:template match="s:listOfUnits/s:unit">
    <xsl:text>s:</xsl:text><xsl:value-of select="@metaid" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a s:unit ;&#10;</xsl:text>
    <xsl:text>  s:is_a s:</xsl:text><xsl:value-of select="../../@id" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  s:kind "</xsl:text><xsl:value-of select="@kind" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   s:unitDefinition -->
  <!-- START s:compartments -->
  
  <xsl:template match="s:listOfCompartments/s:compartment">
    <xsl:text>s:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a s:compartment ;&#10;</xsl:text>
    <xsl:text>  s:metaid "</xsl:text><xsl:value-of select="@metaid" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  s:name "</xsl:text><xsl:value-of select="@name" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  s:size </xsl:text><xsl:value-of select="@size" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>  s:units "</xsl:text><xsl:value-of select="@units" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  s:outside "</xsl:text><xsl:value-of select="@outside" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:apply-templates select="s:annotation/cd:extension/cd:name" />
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  <!-- cd:name IS OPTIONAL -->
  <xsl:template match="s:annotation/cd:extension/cd:name">
    <xsl:text>  cd:name "</xsl:text><xsl:value-of select="." /><xsl:text>" ;&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   s:compartment -->
  <!-- START s:species -->
  
  <xsl:template match="s:listOfSpecies/s:species">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a cd:species ;&#10;</xsl:text>
    <xsl:text>  cd:metaid "</xsl:text><xsl:value-of select="@metaid" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:name "</xsl:text><xsl:value-of select="@name" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:compartment "</xsl:text><xsl:value-of select="@compartment" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:initialAmount "</xsl:text><xsl:value-of select="@initialAmount" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:position_to_compartment "</xsl:text><xsl:value-of select="s:annotation/cd:extension/cd:positionToCompartment/." /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:class cd:</xsl:text><xsl:value-of select="s:annotation/cd:extension/cd:speciesIdentity/cd:class/." /><xsl:text> ;&#10;</xsl:text>
    <xsl:apply-templates select="s:annotation/cd:extension/cd:speciesIdentity/cd:proteinReference" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:speciesIdentity/cd:name" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:listOfCatalyzedReactions/cd:catalyzed" />
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  <!-- cd:proteinReference IS OPTIONAL -->
  <xsl:template match="s:annotation/cd:extension/cd:speciesIdentity/cd:proteinReference">
    <xsl:text>  cd:protein_reference cd:</xsl:text><xsl:value-of select="." /><xsl:text> ;&#10;</xsl:text>
  </xsl:template>
  <!-- cd:name IS OPTIONAL -->
  <xsl:template match="s:annotation/cd:extension/cd:speciesIdentity/cd:name">
    <xsl:text>  cd:name "</xsl:text><xsl:value-of select="." /><xsl:text>" ;&#10;</xsl:text>
  </xsl:template>
  <!-- cd:catalyzed MAY BE MULTIPLE -->
  <xsl:template match="s:annotation/cd:extension/cd:listOfCatalyzedReactions/cd:catalyzed">
    <xsl:text>  cd:catalyzed [&#10;</xsl:text>
    <xsl:text>    cd:reaction "</xsl:text><xsl:value-of select="@reaction" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  ] ;&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   s:species -->
  <!-- START s:reaction -->
  
  <xsl:template match="s:listOfReactions/s:reaction">
    <xsl:text>cd:</xsl:text><xsl:value-of select="@id" /><xsl:text>&#10;</xsl:text>
    <xsl:text>  a cd:reaction ;&#10;</xsl:text>
    <xsl:text>  cd:metaid "</xsl:text><xsl:value-of select="@metaid" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  cd:reversible "</xsl:text><xsl:value-of select="@reversible" /><xsl:text>" ;&#10;</xsl:text>
    <!-- s:notes -->
    <xsl:text>  cd:reaction_type "</xsl:text><xsl:value-of select="s:annotation/cd:extension/cd:reactionType/." /><xsl:text>" ;&#10;</xsl:text>
    <xsl:apply-templates select="s:annotation/cd:extension/cd:baseReactants/cd:baseReactant" />
    <xsl:apply-templates select="s:annotation/cd:extension/cd:baseProducts/cd:baseProduct" />
    <xsl:text>  cd:connect_policy "</xsl:text><xsl:value-of select="s:annotation/cd:extension/cd:connectScheme/@connectPolicy" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:apply-templates select="s:annotation/cd:extension/cd:connectScheme/cd:listOfLineDirection/cd:lineDirection" />
    <!-- cd:num0, cd:num1, cd:num2 (OPTIONAL) -->
    <xsl:text>  .&#10;</xsl:text>
  </xsl:template>
  <!-- cd:baseReactant -->
  <xsl:template match="s:annotation/cd:extension/cd:baseReactants/cd:baseReactant">
    <xsl:text>  cd:base_reactant [&#10;</xsl:text>
    <xsl:text>    cd:species cd:</xsl:text><xsl:value-of select="@species" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>    cd:metaid "</xsl:text><xsl:value-of select="@species" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>    cd:alias "</xsl:text><xsl:value-of select="@alias" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>    cd:position "</xsl:text><xsl:value-of select="cd:linkAnchor/@position" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  ] ;&#10;</xsl:text>
  </xsl:template>
  <!-- cd:baseProduct -->
  <xsl:template match="s:annotation/cd:extension/cd:baseProducts/cd:baseProduct">
    <xsl:text>  cd:base_product [&#10;</xsl:text>
    <xsl:text>    cd:species cd:</xsl:text><xsl:value-of select="@species" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>    cd:metaid "</xsl:text><xsl:value-of select="@species" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>    cd:alias "</xsl:text><xsl:value-of select="@alias" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>    cd:position "</xsl:text><xsl:value-of select="cd:linkAnchor/@position" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  ] ;&#10;</xsl:text>
  </xsl:template>
  <!-- cd:catalyzed MAY BE MULTIPLE -->
  <xsl:template match="s:annotation/cd:extension/cd:connectScheme/cd:listOfLineDirection/cd:lineDirection">
    <xsl:text>  cd:line [&#10;</xsl:text>
    <xsl:text>    cd:arm "</xsl:text><xsl:value-of select="@arm" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>    cd:index </xsl:text><xsl:value-of select="@index" /><xsl:text> ;&#10;</xsl:text>
    <xsl:text>    cd:value "</xsl:text><xsl:value-of select="@value" /><xsl:text>" ;&#10;</xsl:text>
    <xsl:text>  ] ;&#10;</xsl:text>
  </xsl:template>
  
  <!-- END   s:reaction -->

</xsl:stylesheet>