package ru.job4j.servlets.http.logic;

import ru.job4j.servlets.http.persistent.DBStore;
import ru.job4j.servlets.http.persistent.Store;
import ru.job4j.servlets.http.persistent.User;
import ru.job4j.servlets.http.persistent.Validate;

import java.util.List;

/**
 * Class ValidateService validates duplicate id in List of users.
 *
 * @author Evgeny Shpytev (mailto:eshpytev@mail.ru).
 * @version 4.
 * @since 21.08.2019.
 */
public class ValidateService implements Validate {

    /**
     * Instance of singleton.
     */
    private final Store dbStore = DBStore.getInstance();

    /**
     * Instance of singleton.
     */
    private final static ValidateService INSTANCE = new ValidateService();

    public static Validate getInstance() {
        return INSTANCE;
    }

    @Override
    public User add(User user) {
        return this.dbStore.add(user);
    }

    @Override
    public boolean update(User user) {
        this.dbStore.update(user);
        return true;
    }

    @Override
    public boolean delete(User user) {
        boolean result = findById(user.getId()) != null;
        if (result) {
            dbStore.delete(user);
        }
        return result;
    }

    @Override
    public List<User> findAll() {
        return dbStore.findAll();
    }

    @Override
    public User findById(int id) {
        return this.dbStore.findById(id);
    }

    @Override
    public User findByLogin(String login) {
        User user = null;
        try {
            user = this.dbStore.findByLogin(login);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return user;
    }

    @Override
    public User findByEmail(String email) {
        User user = null;
        try {
            user = this.dbStore.findByEmail(email);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean isCredentional(String login, String password) {
        return this.dbStore.findAll().parallelStream()
                .anyMatch(user -> (user.getLogin().equals(login) && user.getPassword().equals(password)));
    }
}