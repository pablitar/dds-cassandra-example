package ar.edu.dds.ejemplocassandra

import org.junit.Test
import static org.junit.Assert.*

class AllUserTest {

	val fixtureUsers = new Fixture().createUsers().sortBy[it.username]

	@Test
	def void testGetAllUsers() {
		val result = CassandraDB.INSTANCE.findUsers.all.sortBy[it.username]
		for (i : 0 .. result.size - 1) {
			assertUserEquals(result.get(i), fixtureUsers.get(i))
		}
	}
	
	def assertUserEquals(User user, User user2) {
		assertEquals(user2.username, user.username)
		assertEquals(user2.displayName, user.displayName)
	}

}
