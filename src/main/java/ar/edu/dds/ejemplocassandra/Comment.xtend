package ar.edu.dds.ejemplocassandra

import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.Frozen
import com.datastax.driver.mapping.annotations.UDT

@UDT(keyspace = "foro", name="comment")
class Comment {
	
	@Accessors
	@Frozen
	CommentUser user
	
	@Accessors
	String comment
	@Accessors
	Long timestamp
}