package com.codingdojo.events.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.events.models.Event;

public interface EventRepository extends CrudRepository<Event, Long> {
	List<Event> findAll();
	List<Event> findByStateOrderByDateAsc (String state);
//	Same as @Query("Select e from Event e where e.state != ?!")
	List<Event> findByStateNotOrderByDateAsc (String state);
//	@Query(value="Select count(user_id) from joined_users_events where event_id = ?1", nativeQuery=true)
//	Long countJoiners(Long id);
}
