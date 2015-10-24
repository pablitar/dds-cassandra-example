package ar.edu.dds.ejemplocassandra

import de.svenjacobs.loremipsum.LoremIpsum
import java.util.ArrayList
import java.util.List
import java.util.Random
import org.eclipse.xtext.xbase.lib.Functions.Function1

class Fixture {

	val seed = 123

	//Using a random generator with a fixed seed we get a random scenario,
	//but that is the same every time this is run.
	val sequenceGenerator = new Random(seed)

	val timestampBase = 1445111641052l

	def createUsers() {
		createList(10, [createUser(it)])
	}

	static val usernames = #["foo", "bar", "zort", "troz", "narf"]

	def createUser(Integer i) {
		new User() => [
			username = usernames.random + i
			displayName = randomDisplayName
			posts = createList(sequenceGenerator.nextInt(6), [createPost])
		]
	}

	def <Type> createList(Integer qty, Function1<Integer, Type> generator) {
		val list = new ArrayList<Type>()
		for (i : 1 .. qty) {
			list.add(generator.apply(i))
		}
		list
	}

	def createPost() {
		val postTimestamp = timestampBase + sequenceGenerator.nextInt
		new Post() => [
			content = new LoremIpsum().getWords(sequenceGenerator.nextInt(400) + 10)
			comments = createList(sequenceGenerator.nextInt(10), [createComment(postTimestamp)])
			timestamp = postTimestamp
		]
	}

	def createComment(long postTimestamp) {
		new Comment() => [
			user = createCommentUser
			comment = new LoremIpsum().getWords(sequenceGenerator.nextInt(200) + 10)
			timestamp = postTimestamp + sequenceGenerator.nextInt
		]
	}

	def createCommentUser() {
		new CommentUser() => [
			username = usernames.random
			displayName = randomDisplayName
		]
	}

	static val names = #["Pablo", "Nicolás", "Gisela", "Darío", "Julieta", "Sandro"]
	static val lastNames = #["López", "García", "Rodriguez", "Días", "Fernandes", "Goldstein"]

	def randomDisplayName() {
		names.random + " " + lastNames.random
	}

	def <T> random(List<T> values) {
		values.get(sequenceGenerator.nextInt(values.size))
	}
	
	def static void main(String[] args) {
		new Fixture().createUsers().forEach[CassandraDB.INSTANCE.saveUser(it)]
		CassandraDB.INSTANCE.close
	}
	

}
