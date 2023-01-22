// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorGasVatDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GasVatDatabaseBuilder databaseBuilder(String name) =>
      _$GasVatDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GasVatDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$GasVatDatabaseBuilder(null);
}

class _$GasVatDatabaseBuilder {
  _$GasVatDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$GasVatDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$GasVatDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<GasVatDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$GasVatDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$GasVatDatabase extends GasVatDatabase {
  _$GasVatDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  ServiceDao? _serviceDaoInstance;

  LogoDao? _logoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserInfo` (`id` INTEGER, `password` TEXT, `email` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Service` (`id` INTEGER, `business_name` TEXT, `address_line1` TEXT, `address_line2` TEXT, `mobile` TEXT, `email` TEXT, `website` TEXT, `vat` REAL, `footer_note` TEXT, `logo_path` TEXT, `createdAt` TEXT, `updatedAt` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Logo` (`id` INTEGER, `name` TEXT, `url` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  ServiceDao get serviceDao {
    return _serviceDaoInstance ??= _$ServiceDao(database, changeListener);
  }

  @override
  LogoDao get logo {
    return _logoInstance ??= _$LogoDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInfoInsertionAdapter = InsertionAdapter(
            database,
            'UserInfo',
            (UserInfo item) => <String, Object?>{
                  'id': item.id,
                  'password': item.password,
                  'email': item.email
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserInfo> _userInfoInsertionAdapter;

  @override
  Future<List<UserInfo>> getUsers() async {
    return _queryAdapter.queryList('SELECT * FROM UserInfo',
        mapper: (Map<String, Object?> row) => UserInfo(
            password: row['password'] as String?,
            email: row['email'] as String?));
  }

  @override
  Future<UserInfo?> deleteUser(int id) async {
    return _queryAdapter.query('DELETE FROM UserInfo WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserInfo(
            password: row['password'] as String?,
            email: row['email'] as String?),
        arguments: [id]);
  }

  @override
  Future<UserInfo?> login(String email) async {
    return _queryAdapter.query('SELECT * FROM UserInfo WHERE email = ?1',
        mapper: (Map<String, Object?> row) => UserInfo(
            password: row['password'] as String?,
            email: row['email'] as String?),
        arguments: [email]);
  }

  @override
  Future<void> cleanUserTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM UserInfo');
  }

  @override
  Future<int> inserUser(UserInfo user) {
    return _userInfoInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.replace);
  }
}

class _$ServiceDao extends ServiceDao {
  _$ServiceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _serviceInsertionAdapter = InsertionAdapter(
            database,
            'Service',
            (Service item) => <String, Object?>{
                  'id': item.id,
                  'business_name': item.business_name,
                  'address_line1': item.address_line1,
                  'address_line2': item.address_line2,
                  'mobile': item.mobile,
                  'email': item.email,
                  'website': item.website,
                  'vat': item.vat,
                  'footer_note': item.footer_note,
                  'logo_path': item.logo_path,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _serviceUpdateAdapter = UpdateAdapter(
            database,
            'Service',
            ['id'],
            (Service item) => <String, Object?>{
                  'id': item.id,
                  'business_name': item.business_name,
                  'address_line1': item.address_line1,
                  'address_line2': item.address_line2,
                  'mobile': item.mobile,
                  'email': item.email,
                  'website': item.website,
                  'vat': item.vat,
                  'footer_note': item.footer_note,
                  'logo_path': item.logo_path,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Service> _serviceInsertionAdapter;

  final UpdateAdapter<Service> _serviceUpdateAdapter;

  @override
  Future<List<Service>> getServiceInfoList() async {
    return _queryAdapter.queryList('SELECT * FROM Service',
        mapper: (Map<String, Object?> row) => Service(
            id: row['id'] as int?,
            business_name: row['business_name'] as String?,
            address_line1: row['address_line1'] as String?,
            address_line2: row['address_line2'] as String?,
            mobile: row['mobile'] as String?,
            email: row['email'] as String?,
            website: row['website'] as String?,
            vat: row['vat'] as double?,
            footer_note: row['footer_note'] as String?,
            logo_path: row['logo_path'] as String?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?));
  }

  @override
  Future<int?> deleteServiceInfo(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Service WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<Service?> getServiceInfoById(int id) async {
    return _queryAdapter.query('SELECT * FROM Service WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Service(
            id: row['id'] as int?,
            business_name: row['business_name'] as String?,
            address_line1: row['address_line1'] as String?,
            address_line2: row['address_line2'] as String?,
            mobile: row['mobile'] as String?,
            email: row['email'] as String?,
            website: row['website'] as String?,
            vat: row['vat'] as double?,
            footer_note: row['footer_note'] as String?,
            logo_path: row['logo_path'] as String?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> cleanServiceInfoTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Service');
  }

  @override
  Future<int> inserServiceInfo(Service service) {
    return _serviceInsertionAdapter.insertAndReturnId(
        service, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateServiceInfo(Service service) {
    return _serviceUpdateAdapter.updateAndReturnChangedRows(
        service, OnConflictStrategy.abort);
  }
}

class _$LogoDao extends LogoDao {
  _$LogoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _logoInsertionAdapter = InsertionAdapter(
            database,
            'Logo',
            (Logo item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'url': item.url
                }),
        _logoUpdateAdapter = UpdateAdapter(
            database,
            'Logo',
            ['id'],
            (Logo item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'url': item.url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Logo> _logoInsertionAdapter;

  final UpdateAdapter<Logo> _logoUpdateAdapter;

  @override
  Future<List<Logo>> getLogoList() async {
    return _queryAdapter.queryList('SELECT * FROM Logo',
        mapper: (Map<String, Object?> row) => Logo(
            id: row['id'] as int?,
            name: row['name'] as String?,
            url: row['url'] as String?));
  }

  @override
  Future<int?> deleteLogo(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Logo WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<List<Logo>> getLogoBYSearch(String name) async {
    return _queryAdapter.queryList('SELECT * FROM Logo WHERE name = ?1',
        mapper: (Map<String, Object?> row) => Logo(
            id: row['id'] as int?,
            name: row['name'] as String?,
            url: row['url'] as String?),
        arguments: [name]);
  }

  @override
  Future<void> cleanServiceInfoTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Logo');
  }

  @override
  Future<int> inserLogoInfo(Logo logo) {
    return _logoInsertionAdapter.insertAndReturnId(
        logo, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateServiceInfo(Logo logo) {
    return _logoUpdateAdapter.updateAndReturnChangedRows(
        logo, OnConflictStrategy.abort);
  }
}
