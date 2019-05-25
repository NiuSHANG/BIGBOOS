package service;


import dao.*;
import entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.GregorianCalendar;
import java.text.SimpleDateFormat;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;
import java.util.Optional;


@Service
@Transactional
public class UserServiceImpl implements UserService {
	
	 @Autowired
	    AdminRepository adminRepo;

	    @Autowired
	    BookCopyRepository bookCopyRepo;

	    @Autowired
	    BookProfileRepository bookProfileRepo;

	    @Autowired
	    BorrowerRepository borrowerRepo;

	    @Autowired
	    RecordRepository recordRepo;

		@Override
		public Borrower login(String username, String password) {
			 Optional<Borrower> user = borrowerRepo.findBorrowerByName(username);
		        return user.isPresent() && user.get().getPassword().equals(password) ? user.get() : null;
		}
		@Override
		public boolean update(Borrower user) {
			return borrowerRepo.save(user);
		}

		@Override
		public List<BookProfile> findBookByCriteria(Map<String, Object> criteria) {
			 return bookProfileRepo.findAll(ServiceUtils.convertMapToSpec(criteria));
		}

		@Override
		public List<Record> findRecordOfSomeone(int uid) {
			List<Record> Rcd1 = recordRepo.findRecordsByBorrowerId(uid);
			return Rcd;
		}

		@Override
		public Record borrow(Borrower user, BookCopy copy) {
			GregorianCalendar now = new GregorianCalendar();
			Record Rcd;
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			now.add(GregorianCalendar.MONTH,2);
			Rcd.set().setBorrower(user) ;
			Rcd.set().setBookCopy(copy);
			Rcd.set().setInstant(df);
			Rcd.set().setLocalDate(now.getTime());
			
			
			return recordRepo.save(Rcd);
		}
		@Override
		public Record returnBack(int id) {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Optional<Record> Rcd = recordRepo.findRecordById(id);
			Rcd.set().setInstant(df);
			return recordRepo.save(Rcd);
		}

}
