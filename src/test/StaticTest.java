package test;

public class StaticTest {
	final String test;
	StaticTest(){
		test = "123";
	}
	
	public static void main(String[] args) {
		StaticTest st = new StaticTest();
		System.out.println(st.test);
	}

}
