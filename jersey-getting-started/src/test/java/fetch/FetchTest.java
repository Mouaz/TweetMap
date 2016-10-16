package fetch;

import static org.junit.Assert.*;
import jersey.getting.started.Fetcher;

import org.junit.Test;
public class FetchTest {

	/**
	 * test method name: testFetchingTweets
	 * description: test number of tweets and their content
	 * 				according to count and keyword
	 */
	@Test
	public void testFetchingTweets(){
		assertEquals(Fetcher.getTweets("vodafone", 100), 100);
	}
}
