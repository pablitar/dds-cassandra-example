package ar.edu.dds.ejemplocassandra

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Host
import com.datastax.driver.core.Metadata
import com.datastax.driver.core.Session
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager

class CassandraDB {

	public static val INSTANCE = new CassandraDB("127.0.0.1")

	val Cluster cluster
	val Session session
	val Mapper<User> userMapper
	val MappingManager manager
	
	UserAccessor accessor

	new(String node) {
		this.cluster = Cluster.builder().addContactPoint(node).build()
		logMetadata()
		this.session = this.cluster.connect()
		manager = new MappingManager(this.session)
		userMapper = (manager).mapper(User);
		accessor = manager.createAccessor(UserAccessor)
	}

	def logMetadata() {
		var Metadata metadata = cluster.getMetadata()
		System.out.printf("Connecting to cluster: %s\n", metadata.getClusterName())
		for (Host host : metadata.getAllHosts()) {
			System.out.printf("Datacenter: %s; Host: %s; Rack: %s\n", host.getDatacenter(), host.getAddress(),
				host.getRack())
		}
	}

	def close() {
		cluster.close
	}

	def saveUser(User user) {
		userMapper.save(user)
	}

	def findUsers() {
		accessor.all
	}

}
