package ar.edu.dds.ejemplocassandra

import com.datastax.driver.mapping.annotations.FrozenValue
import com.datastax.driver.mapping.annotations.UDT
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@UDT(keyspace = "foro", name="post")
class Post {
	@Accessors
	String content
	@Accessors
	Long timestamp
	
	@Accessors
	@FrozenValue
	List<Comment> comments
}