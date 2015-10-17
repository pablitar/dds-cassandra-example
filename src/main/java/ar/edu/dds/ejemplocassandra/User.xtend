package ar.edu.dds.ejemplocassandra

import com.datastax.driver.mapping.annotations.FrozenValue
import com.datastax.driver.mapping.annotations.Table
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.PartitionKey

@Table(keyspace="foro", name="users")
class User {
	@Accessors
	@FrozenValue
	List<Post> posts

	@Accessors
	@PartitionKey
	String username
	@Accessors
	String displayName
}
