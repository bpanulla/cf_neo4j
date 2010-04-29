<cfset neo4jHelper = CreateObject("component", "org.fraught.neo4j.neo4j").initialize("/tmp/neo4jtest/var/graphdb") />

<cftry>
	<cfset tx = neo4jHelper.beginTx() />
	
	<cfscript>
		firstNode = neo4jHelper.createNode();
		secondNode = neo4jHelper.createNode();
		relationship = firstNode.createRelationshipTo( secondNode, neo4jHelper.getRelationship("KNOWS") );
		 
		firstNode.setProperty( "message", "Hello, " );
		secondNode.setProperty( "message", "world!" );
		relationship.setProperty( "message", "brave Neo4j " );

		WriteOutput( firstNode.getProperty( "message" ) );
		WriteOutput( relationship.getProperty( "message" ) );
		WriteOutput( secondNode.getProperty( "message" ) );

		tx.success();
	</cfscript>
	

	<cfset tx.finish() />
	<cfcatch type="any">
		<cfset neo4jHelper.shutdown() />
		<cfdump var="#cfcatch#">
	</cfcatch>
</cftry>

<cfset neo4jHelper.shutdown() />
Done.