package ar.edu.dds.ejemplocassandra

import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.PartitionKey

class AbstractUser {
	@Accessors
	@PartitionKey
	String username
	@Accessors
	String displayName
}
