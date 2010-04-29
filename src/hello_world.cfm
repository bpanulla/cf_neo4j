<cfset dbroot = "/tmp/neo4jtest/" />

<cfset graphDb = createObject('java',"org.neo4j.kernel.EmbeddedGraphDatabase") />
<cfset graphDb.init(dbroot & "var/graphdb") />

<cfset relationship = CreateObject("java", "org.neo4j.graphdb.DynamicRelationshipType") />

<cftry>
	<cfset tx = graphDb.beginTx() />
	
	<cfscript>
		MyRelationshipTypes = structNew();
		MyRelationshipTypes.KNOWS = relationship.withName( "KNOWS" );
		
		firstNode = graphDb.createNode();
		secondNode = graphDb.createNode();
		relationship = firstNode.createRelationshipTo( secondNode, MyRelationshipTypes.KNOWS );
		 
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
		<cfset graphDb.shutdown() />
		<cfdump var="#cfcatch#">
	</cfcatch>
</cftry>

<cfset graphDb.shutdown() />
Done.