<cfcomponent output="false" displayname="Neo4J Graph Database Faade" hint="Provides simplified access to a Neo4j Graph Database to ColdFusion applications">


	<!--- Private properties --->
	<cfset variables.graphDb = CreateObject('java',"org.neo4j.kernel.EmbeddedGraphDatabase") />
	<cfset variables.relationshipTemplate = CreateObject("java", "org.neo4j.graphdb.DynamicRelationshipType")>
	
	<!--- Public methods --->
	<cffunction name="isInitialized" access="public" output="false" returntype="Boolean" hint="Tell if graph database connection has been initialized.">
	
		<cfset var status = true />
		<cfset var pathTest = "" />

		<cftry>
			<cfset pathTest = getPath() />

			<cfcatch type="any">
				<cfset status = false />
			</cfcatch>	
		</cftry>
		
		<cfreturn status />	
	</cffunction>


	<cffunction name="initialize" access="public" output="false" returntype="Any">
		<cfargument name="path" type="string" required="false" />
	
		<cfset var status = true />

		<cftry>
			<cfset variables.graphDb.init(arguments.path) />

			<cfcatch type="any">
				<cfset status = false />
			</cfcatch>	
		</cftry>
		
		<cfreturn this />
	</cffunction>


	<cffunction name="getPath" access="public" output="false" returntype="string">
		<cfreturn graphDb.getStoreDir() />
	</cffunction>
	
	
	<cffunction name="createNode" access="public" output="false" returntype="any">
		<cfreturn graphDb.createNode() />
	</cffunction>

	<cffunction name="beginTx" access="public" output="false" returntype="any">
		<cfreturn graphDb.beginTx() />
	</cffunction>

	<cffunction name="getRelationship" access="public" output="false" returntype="any">
		<cfargument name="relName" type="string" required="true">
		
		<cfreturn variables.relationshipTemplate.withName( arguments.relName ) />
	</cffunction>
	
	<cffunction name="shutdown" access="public" output="false" returntype="any">		
		<cfreturn graphDb.shutdown() />
	</cffunction>
	


</cfcomponent>