package org.project.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.project.domain.User.ProfileImageVO;
import org.project.mapper.User.ProfileImageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ProfileImageMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ProfileImageMapper pmapper;
		
	/*�����ʵ��-���Խ�*/
	@Test
	public void testInsertProfile() {		
		ProfileImageVO profile = new ProfileImageVO();
		//�׽�Ʈ�� ���� �ӽ÷� �ۼ�
		profile.setUserid("qwerty");
		profile.setFileName("test2.jpg");
		profile.setFileType(true);
		profile.setUploadPath("C:\\upload");
		profile.setUuid("gengi;opehjiejafgqgoh");
		pmapper.insert(profile);
	}	
	
	/*��������ȸ*/
	@Test
	public void testGetProfile() {
		pmapper.getProfileByUserid("qwerty");
	}
	
	/*�����ʼ���*/
	@Test
	public void testUpdateProfile() {
		ProfileImageVO profile = pmapper.getProfileByUserid("qwerty");		
		profile.setFileName("testUpdate.png");
		profile.setFileType(true);
		profile.setUploadPath("C:\\upload");
		profile.setUuid("gengi;opehjiejafgqgohda");
		pmapper.update(profile);
	}
		
	/*�����ʻ���-Ż���*/
	@Test
	public void testDeleteProfile() {
		ProfileImageVO profile = pmapper.getProfileByUserid("qwerty");
		pmapper.delete(profile.getUserid());
	}
}