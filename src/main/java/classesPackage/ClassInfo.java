package classesPackage;

public class ClassInfo {
	
	private String id;
	private String course_abbreviation;
	private String course_name;
	private String enrollment;
	private String capacity;
	
	
	
	
	public ClassInfo(String id, String course_abbreviation, String course_name) {
		super();
		this.id = id;
		this.course_abbreviation = course_abbreviation;
		this.course_name = course_name;
	}
	
	public ClassInfo(String id, String course_abbreviation, String course_name, String enrollment, String capacity) {
		super();
		this.id = id;
		this.course_abbreviation = course_abbreviation;
		this.course_name = course_name;
		this.enrollment = enrollment;
		this.capacity = capacity;
	}

	public ClassInfo(String id) {
		super();
		this.id = id;
	}
	public ClassInfo()
	{
		
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCourse_abbreviation() {
		return course_abbreviation;
	}
	public void setCourse_abbreviation(String course_abbreviation) {
		this.course_abbreviation = course_abbreviation;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getEnrollment() {
		return enrollment;
	}
	public void setEnrollment(String enrollment) {
		this.enrollment = enrollment;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}
	
	
	
	

}
