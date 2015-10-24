package ar.edu.dds.ejemplocassandra

import com.datastax.driver.mapping.Result
import com.datastax.driver.mapping.annotations.Accessor
import com.datastax.driver.mapping.annotations.Query

@Accessor	
interface UserAccessor {
	@Query("SELECT * FROM foro.users")
	def Result<User> getAll()
}
	