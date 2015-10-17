package ar.edu.dds.ejemplocassandra

import com.datastax.driver.mapping.annotations.UDT
import org.eclipse.xtend.lib.annotations.Accessors

@UDT(keyspace="foro", name="comment_user")
class CommentUser {
	@Accessors
	String username
	@Accessors
	String displayName
}
