// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name

import 'dart:convert';
import 'dart:typed_data';

import '../../shared/shared.dart' as _s;
import '../../shared/shared.dart'
    show
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

export '../../shared/shared.dart' show AwsClientCredentials;

/// Amazon Personalize can consume real-time user event data, such as
/// <i>stream</i> or <i>click</i> data, and use it for model training either
/// alone or combined with historical data. For more information see <a
/// href="https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html">Recording
/// Events</a>.
class PersonalizeEvents {
  final _s.RestJsonProtocol _protocol;
  PersonalizeEvents({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'personalize-events',
            signingName: 'personalize',
          ),
          region: region,
          credentials: credentials,
          credentialsProvider: credentialsProvider,
          endpointUrl: endpointUrl,
        );

  /// Closes the internal HTTP client if none was provided at creation.
  /// If a client was passed as a constructor argument, this becomes a noop.
  ///
  /// It's important to close all clients when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  void close() {
    _protocol.close();
  }

  /// Records user interaction event data. For more information see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html">Recording
  /// Events</a>.
  ///
  /// May throw [InvalidInputException].
  ///
  /// Parameter [eventList] :
  /// A list of event data from the session.
  ///
  /// Parameter [sessionId] :
  /// The session ID associated with the user's visit. Your application
  /// generates the sessionId when a user first visits your website or uses your
  /// application. Amazon Personalize uses the sessionId to associate events
  /// with the user before they log in. For more information, see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html">Recording
  /// Events</a>.
  ///
  /// Parameter [trackingId] :
  /// The tracking ID for the event. The ID is generated by a call to the <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/API_CreateEventTracker.html">CreateEventTracker</a>
  /// API.
  ///
  /// Parameter [userId] :
  /// The user associated with the event.
  Future<void> putEvents({
    required List<Event> eventList,
    required String sessionId,
    required String trackingId,
    String? userId,
  }) async {
    final $payload = <String, dynamic>{
      'eventList': eventList,
      'sessionId': sessionId,
      'trackingId': trackingId,
      if (userId != null) 'userId': userId,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/events',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Adds one or more items to an Items dataset. For more information see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/importing-items.html">Importing
  /// Items Incrementally</a>.
  ///
  /// May throw [InvalidInputException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ResourceInUseException].
  ///
  /// Parameter [datasetArn] :
  /// The Amazon Resource Name (ARN) of the Items dataset you are adding the
  /// item or items to.
  ///
  /// Parameter [items] :
  /// A list of item data.
  Future<void> putItems({
    required String datasetArn,
    required List<Item> items,
  }) async {
    final $payload = <String, dynamic>{
      'datasetArn': datasetArn,
      'items': items,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/items',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Adds one or more users to a Users dataset. For more information see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/importing-users.html">Importing
  /// Users Incrementally</a>.
  ///
  /// May throw [InvalidInputException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ResourceInUseException].
  ///
  /// Parameter [datasetArn] :
  /// The Amazon Resource Name (ARN) of the Users dataset you are adding the
  /// user or users to.
  ///
  /// Parameter [users] :
  /// A list of user data.
  Future<void> putUsers({
    required String datasetArn,
    required List<User> users,
  }) async {
    final $payload = <String, dynamic>{
      'datasetArn': datasetArn,
      'users': users,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/users',
      exceptionFnMap: _exceptionFns,
    );
  }
}

/// Represents user interaction event information sent using the
/// <code>PutEvents</code> API.
class Event {
  /// The type of event, such as click or download. This property corresponds to
  /// the <code>EVENT_TYPE</code> field of your Interactions schema and depends on
  /// the types of events you are tracking.
  final String eventType;

  /// The timestamp (in Unix time) on the client side when the event occurred.
  final DateTime sentAt;

  /// An ID associated with the event. If an event ID is not provided, Amazon
  /// Personalize generates a unique ID for the event. An event ID is not used as
  /// an input to the model. Amazon Personalize uses the event ID to distinquish
  /// unique events. Any subsequent events after the first with the same event ID
  /// are not used in model training.
  final String? eventId;

  /// The event value that corresponds to the <code>EVENT_VALUE</code> field of
  /// the Interactions schema.
  final double? eventValue;

  /// A list of item IDs that represents the sequence of items you have shown the
  /// user. For example, <code>["itemId1", "itemId2", "itemId3"]</code>. Provide a
  /// list of items to manually record impressions data for an event. For more
  /// information on recording impressions data, see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html#putevents-including-impressions-data">Recording
  /// impressions data</a>.
  final List<String>? impression;

  /// The item ID key that corresponds to the <code>ITEM_ID</code> field of the
  /// Interactions schema.
  final String? itemId;

  /// Contains information about the metric attribution associated with an event.
  /// For more information about metric attributions, see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html">Measuring
  /// impact of recommendations</a>.
  final MetricAttribution? metricAttribution;

  /// A string map of event-specific data that you might choose to record. For
  /// example, if a user rates a movie on your site, other than movie ID
  /// (<code>itemId</code>) and rating (<code>eventValue</code>) , you might also
  /// send the number of movie ratings made by the user.
  ///
  /// Each item in the map consists of a key-value pair. For example,
  ///
  /// <code>{"numberOfRatings": "12"}</code>
  ///
  /// The keys use camel case names that match the fields in the Interactions
  /// schema. In the above example, the <code>numberOfRatings</code> would match
  /// the 'NUMBER_OF_RATINGS' field defined in the Interactions schema.
  final Object? properties;

  /// The ID of the list of recommendations that contains the item the user
  /// interacted with. Provide a <code>recommendationId</code> to have Amazon
  /// Personalize implicitly record the recommendations you show your user as
  /// impressions data. Or provide a <code>recommendationId</code> if you use a
  /// metric attribution to measure the impact of recommendations.
  ///
  /// For more information on recording impressions data, see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html#putevents-including-impressions-data">Recording
  /// impressions data</a>. For more information on creating a metric attribution
  /// see <a
  /// href="https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html">Measuring
  /// impact of recommendations</a>.
  final String? recommendationId;

  Event({
    required this.eventType,
    required this.sentAt,
    this.eventId,
    this.eventValue,
    this.impression,
    this.itemId,
    this.metricAttribution,
    this.properties,
    this.recommendationId,
  });

  Map<String, dynamic> toJson() {
    final eventType = this.eventType;
    final sentAt = this.sentAt;
    final eventId = this.eventId;
    final eventValue = this.eventValue;
    final impression = this.impression;
    final itemId = this.itemId;
    final metricAttribution = this.metricAttribution;
    final properties = this.properties;
    final recommendationId = this.recommendationId;
    return {
      'eventType': eventType,
      'sentAt': unixTimestampToJson(sentAt),
      if (eventId != null) 'eventId': eventId,
      if (eventValue != null) 'eventValue': eventValue,
      if (impression != null) 'impression': impression,
      if (itemId != null) 'itemId': itemId,
      if (metricAttribution != null) 'metricAttribution': metricAttribution,
      if (properties != null) 'properties': jsonEncode(properties),
      if (recommendationId != null) 'recommendationId': recommendationId,
    };
  }
}

/// Represents item metadata added to an Items dataset using the
/// <code>PutItems</code> API. For more information see <a
/// href="https://docs.aws.amazon.com/personalize/latest/dg/importing-items.html">Importing
/// Items Incrementally</a>.
class Item {
  /// The ID associated with the item.
  final String itemId;

  /// A string map of item-specific metadata. Each element in the map consists of
  /// a key-value pair. For example, <code>{"numberOfRatings": "12"}</code>.
  ///
  /// The keys use camel case names that match the fields in the schema for the
  /// Items dataset. In the previous example, the <code>numberOfRatings</code>
  /// matches the 'NUMBER_OF_RATINGS' field defined in the Items schema. For
  /// categorical string data, to include multiple categories for a single item,
  /// separate each category with a pipe separator (<code>|</code>). For example,
  /// <code>\"Horror|Action\"</code>.
  final Object? properties;

  Item({
    required this.itemId,
    this.properties,
  });

  Map<String, dynamic> toJson() {
    final itemId = this.itemId;
    final properties = this.properties;
    return {
      'itemId': itemId,
      if (properties != null) 'properties': jsonEncode(properties),
    };
  }
}

/// Contains information about a metric attribution associated with an event.
/// For more information about metric attributions, see <a
/// href="https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html">Measuring
/// impact of recommendations</a>.
class MetricAttribution {
  /// The source of the event, such as a third party.
  final String eventAttributionSource;

  MetricAttribution({
    required this.eventAttributionSource,
  });

  Map<String, dynamic> toJson() {
    final eventAttributionSource = this.eventAttributionSource;
    return {
      'eventAttributionSource': eventAttributionSource,
    };
  }
}

/// Represents user metadata added to a Users dataset using the
/// <code>PutUsers</code> API. For more information see <a
/// href="https://docs.aws.amazon.com/personalize/latest/dg/importing-users.html">Importing
/// Users Incrementally</a>.
class User {
  /// The ID associated with the user.
  final String userId;

  /// A string map of user-specific metadata. Each element in the map consists of
  /// a key-value pair. For example, <code>{"numberOfVideosWatched": "45"}</code>.
  ///
  /// The keys use camel case names that match the fields in the schema for the
  /// Users dataset. In the previous example, the
  /// <code>numberOfVideosWatched</code> matches the 'NUMBER_OF_VIDEOS_WATCHED'
  /// field defined in the Users schema. For categorical string data, to include
  /// multiple categories for a single user, separate each category with a pipe
  /// separator (<code>|</code>). For example, <code>\"Member|Frequent
  /// shopper\"</code>.
  final Object? properties;

  User({
    required this.userId,
    this.properties,
  });

  Map<String, dynamic> toJson() {
    final userId = this.userId;
    final properties = this.properties;
    return {
      'userId': userId,
      if (properties != null) 'properties': jsonEncode(properties),
    };
  }
}

class InvalidInputException extends _s.GenericAwsException {
  InvalidInputException({String? type, String? message})
      : super(type: type, code: 'InvalidInputException', message: message);
}

class ResourceInUseException extends _s.GenericAwsException {
  ResourceInUseException({String? type, String? message})
      : super(type: type, code: 'ResourceInUseException', message: message);
}

class ResourceNotFoundException extends _s.GenericAwsException {
  ResourceNotFoundException({String? type, String? message})
      : super(type: type, code: 'ResourceNotFoundException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'InvalidInputException': (type, message) =>
      InvalidInputException(type: type, message: message),
  'ResourceInUseException': (type, message) =>
      ResourceInUseException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
};