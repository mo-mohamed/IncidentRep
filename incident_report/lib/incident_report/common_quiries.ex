# defmodule IncidentReport.DAL.CommonQueries do
#   alias IncidentReport.Repo
#   import Ecto.Query, only: [preload: 2, select: 3, from: 2]
#   #use EventBus.EventSource

#   @moduledoc false
#   defmacro __using__(opts) do
#     quote do
#       alias IncidentReport.Repo
#       import Ecto.Query, only: [from: 2, preload: 2, select: 3, order_by: 3]

#       alias unquote(opts[:schema_module])

#       def get!(id, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.get!(unquote(opts[:schema_module]), id, opts)

#       def get(id, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.get(unquote(opts[:schema_module]), id, opts)

#       def get(id, company_id, user_role, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.get(unquote(opts[:schema_module]), id, company_id, user_role, opts)

#       def get_by!(%{} = params, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.get_by!(unquote(opts[:schema_module]), params, opts)

#       def get_by(%{} = params, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.get_by(unquote(opts[:schema_module]), params, opts)

#       def get_by(%{} = params, company_id, user_role, opts \\ []),
#         do:
#           IncidentReport.DAL.CommonQueries.get_by(
#             unquote(opts[:schema_module]),
#             params,
#             company_id,
#             user_role,
#             opts
#           )

#       def find_by(params, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.find_by(unquote(opts[:schema_module]), params, opts)

#       def find_by(params, company_id, user_role, opts \\ []),
#         do:
#           IncidentReport.DAL.CommonQueries.find_by(
#             unquote(opts[:schema_module]),
#             params,
#             company_id,
#             user_role,
#             opts
#           )

#       def get_all_columns(),
#         do: IncidentReport.DAL.CommonQueries.get_all_columns(unquote(opts[:schema_module]))

#       def create(%Ecto.Changeset{} = params), do: IncidentReport.DAL.CommonQueries.create(params)

#       def create(params), do: IncidentReport.DAL.CommonQueries.create(unquote(opts[:schema_module]), params)

#       # def create_with_event(params, event_data \\ []),
#       #   do:
#       #     IncidentReport.DAL.CommonQueries.create_with_event(unquote(opts[:schema_module]), params, event_data)

#       # def event_publish(params, event_data \\ []),
#       #   do: IncidentReport.DAL.CommonQueries.event_publish(params, event_data, unquote(opts[:schema_module]))

#       def all(opts \\ []), do: IncidentReport.DAL.CommonQueries.all(unquote(opts[:schema_module]), opts)

#       def all(company_id, user_role, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.all(unquote(opts[:schema_module]), company_id, user_role, opts)

#       # def all_paginate(page_number, page_size, preloads \\ []),
#       #   do:
#       #     IncidentReport.DAL.CommonQueries.all_paginate(
#       #       unquote(opts[:schema_module]),
#       #       page_number,
#       #       page_size,
#       #       preloads
#       #     )

#       # def all_paginate(company_id, user_role, page_number, page_size, preloads \\ []),
#       #   do:
#       #     IncidentReport.DAL.CommonQueries.all_paginate(
#       #       unquote(opts[:schema_module]),
#       #       company_id,
#       #       user_role,
#       #       page_number,
#       #       page_size,
#       #       preloads
#       #     )

#       def update(%unquote(opts[:schema_module]){} = arg, %{} = attrs),
#         do: IncidentReport.DAL.CommonQueries.update(unquote(opts[:schema_module]), arg, attrs)

#       def update(id, company_id, user_role, %{} = attrs),
#         do:
#           IncidentReport.DAL.CommonQueries.update(
#             unquote(opts[:schema_module]),
#             id,
#             company_id,
#             user_role,
#             attrs
#           )

#       def update!(%unquote(opts[:schema_module]){} = arg, %{} = attrs),
#         do: IncidentReport.DAL.CommonQueries.update!(unquote(opts[:schema_module]), arg, attrs)

#       def insert_or_update(params, target),
#         do: IncidentReport.DAL.CommonQueries.insert_or_update(unquote(opts[:schema_module]), params, target)

#       def insert_or_update(params),
#         do: IncidentReport.DAL.CommonQueries.insert_or_update(unquote(opts[:schema_module]), params)

#       def insert_all(params, opts \\ []),
#         do: IncidentReport.DAL.CommonQueries.insert_all(unquote(opts[:schema_module]), params, opts)

#       def count(query), do: IncidentReport.DAL.CommonQueries.count(query)

#       def count(), do: IncidentReport.DAL.CommonQueries.count(unquote(opts[:schema_module]))

#       def delete(struct), do: IncidentReport.DAL.CommonQueries.delete(struct, unquote(opts[:schema_module]))

#       def delete_all(query), do: IncidentReport.DAL.CommonQueries.delete_all(query)

#       def delete_all(), do: IncidentReport.DAL.CommonQueries.delete_all(unquote(opts[:schema_module]))

#       def changeset(), do: IncidentReport.DAL.CommonQueries.changeset(unquote(opts[:schema_module]))

#       def changeset(%unquote(opts[:schema_module]){} = struct),
#         do: IncidentReport.DAL.CommonQueries.changeset(unquote(opts[:schema_module]), struct)

#       def changeset(%unquote(opts[:schema_module]){} = struct, %{} = params),
#         do: IncidentReport.DAL.CommonQueries.changeset(unquote(opts[:schema_module]), struct, params)

#       def most_recent_version_action_query(action),
#         do:
#           IncidentReport.DAL.CommonQueries.most_recent_version_action_query(
#             unquote(opts[:schema_module]),
#             action
#           )

#       def prepare_trackable_users_query(entity_id, action),
#         do: IncidentReport.DAL.CommonQueries.prepare_trackable_users_query(entity_id, action)

#       defdelegate change(), to: __MODULE__, as: :changeset

#       defdelegate change(args1), to: __MODULE__, as: :changeset

#       defoverridable create: 1
#     end
#   end

#   def get!(module, id, opts \\ [])

#   def get!(module, id, opts) when is_atom(opts), do: get!(module, id, preloads: opts)

#   def get!(module, id, opts) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)

#     module
#     |> select_function(return_type, select_block)
#     |> preload(^preloads)
#     |> Repo.get!(id)
#   end

#   def get(module, id, opts \\ [])

#   def get(module, id, opts) when is_atom(opts), do: get(module, id, preloads: opts)

#   def get(module, id, opts) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)

#     queryable =
#       module
#       |> select_function(return_type, select_block)
#       |> preload(^preloads)

#     with {:ok, uuid} <- Ecto.UUID.cast(id),
#          result when not is_nil(result) <- Repo.get(queryable, uuid) do
#       {:ok, result}
#     else
#       :error -> {:error, :bad_request}
#       _ -> {:error, :not_found}
#     end
#   end

#   def get(module, id, company_id, user_role, opts \\ []) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)

#     queryable =
#       module
#       |> select_function(return_type, select_block)
#       |> Bodyguard.scope(company_id, user_role)
#       |> preload(^preloads)

#     with {:ok, uuid} <- Ecto.UUID.cast(id),
#          result when not is_nil(result) <- Repo.get(queryable, uuid) do
#       {:ok, result}
#     else
#       :error -> {:error, :bad_request}
#       _ -> {:error, :not_found}
#     end
#   end

#   def get_by!(module, params, opts \\ [])

#   def get_by!(module, %{} = params, opts) when is_atom(opts),
#     do: get_by!(module, params, preloads: opts)

#   def get_by!(module, %{} = params, opts) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)

#     module
#     |> select_function(return_type, select_block)
#     |> preload(^preloads)
#     |> Repo.get_by!(params)
#   end

#   def get_by(module, params, opts \\ [])

#   def get_by(module, %{} = params, opts) when is_atom(opts),
#     do: get_by(module, params, preloads: opts)

#   def get_by(module, %{} = params, opts) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)

#     result =
#       module
#       |> select_function(return_type, select_block)
#       |> preload(^preloads)
#       |> Repo.get_by(params)

#     case result do
#       nil -> {:error, :not_found}
#       _ -> {:ok, result}
#     end
#   end

#   def get_by(module, %{} = params, company_id, user_role, opts \\ []) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)

#     result =
#       module
#       |> select_function(return_type, select_block)
#       |> Bodyguard.scope(company_id, user_role)
#       |> preload(^preloads)
#       |> Repo.get_by(params)

#     case result do
#       nil -> {:error, :not_found}
#       _ -> {:ok, result}
#     end
#   end

#   def find_by(module, params, opts \\ []) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)
#     order_block = Keyword.get(opts, :order_by, [])
#     distinct_block = Keyword.get(opts, :distinct, [])

#     paginate = Keyword.get(opts, :paginate, nil)

#     query =
#       module
#       |> select_function(return_type, select_block)
#       |> preload(^preloads)
#       |> Ecto.Query.where(^params)
#       |> Ecto.Query.distinct(^distinct_block)
#       |> Ecto.Query.order_by(^order_block)

#     case paginate do
#       %{} = page_meta -> query |> Repo.paginate(page_meta)
#       _ -> query |> Repo.all()
#     end
#   end

#   def find_by(module, params, company_id, user_role, opts \\ []) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)
#     paginate = Keyword.get(opts, :paginate, nil)

#     query =
#       module
#       |> select_function(return_type, select_block)
#       |> Ecto.Query.where(^params)
#       |> Bodyguard.scope(company_id, user_role)
#       |> preload(^preloads)

#     case paginate do
#       %{} = page_meta -> query |> Repo.paginate(page_meta)
#       _ -> query |> Repo.all()
#     end
#   end

#   def create(%Ecto.Changeset{} = params) do
#     params
#     |> Repo.insert()
#   end

#   def create(module, params) do
#     struct(module)
#     |> module.changeset(params)
#     |> Repo.insert()
#   end

#   # def create_with_event(module, params, event_data \\ [])

#   # def create_with_event(module, %Ecto.Changeset{} = changeset, event_data) do
#   #   changeset
#   #   |> Repo.insert()
#   #   |> event_publish(event_data, module)
#   # end

#   # def create_with_event(module, params, event_data) do
#   #   struct(module)
#   #   |> module.changeset(params)
#   #   |> Repo.insert()
#   #   |> event_publish(event_data, module)
#   # end

#   def all(module, opts \\ []) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)
#     order_by_params = Keyword.get(opts, :order_by, [])

#     result =
#       module
#       |> select_function(return_type, select_block)
#       |> preload(^preloads)

#     result =
#       case order_by_params do
#         [] -> result
#         res -> result |> Ecto.Query.order_by(^res)
#       end

#     result
#     |> Repo.all()
#     |> result_view(select_block, return_type)
#   end

#   def all(module, company_id, user_role, opts \\ []) do
#     preloads = Keyword.get(opts, :preloads, [])
#     select_block = Keyword.get(opts, :select, [])
#     return_type = Keyword.get(opts, :type, :struct)
#     order_by_params = Keyword.get(opts, :order_by, [])

#     result =
#       module
#       |> select_function(return_type, select_block)
#       |> Bodyguard.scope(company_id, user_role)
#       |> preload(^preloads)

#     result =
#       case order_by_params do
#         [] -> result
#         res -> result |> Ecto.Query.order_by(^res)
#       end

#     result
#     |> Repo.all()
#     |> result_view(select_block, return_type)
#   end

#   def get_all_columns(module) do
#     module.__schema__(:fields)
#   end

#   defp result_view(result, select_block, return_type) do
#     if return_type == :tuple do
#       Enum.map(result, fn row ->
#         Enum.reduce(select_block, {}, fn label, tuple ->
#           Tuple.append(tuple, row[label])
#         end)
#       end)
#     else
#       result
#     end
#   end

#   # def all_paginate(module, page_number, page_size, opts \\ []) do
#   #   preloads = Keyword.get(opts, :preloads, [])
#   #   order_by_params = Keyword.get(opts, :order_by, [])

#   #   result =
#   #     module
#   #     |> preload(^preloads)

#   #   result =
#   #     case order_by_params do
#   #       [] -> result
#   #       res -> result |> Ecto.Query.order_by(^res)
#   #     end

#   #   result
#   #   |> Repo.paginate(page: page_number, page_size: page_size)
#   # end

#   # def all_paginate(module, company_id, user_role, page_number, page_size, opts \\ []) do
#   #   preloads = Keyword.get(opts, :preloads, [])
#   #   order_by_params = Keyword.get(opts, :order_by, [])

#   #   result =
#   #     module
#   #     |> Bodyguard.scope(company_id, user_role)
#   #     |> preload(^preloads)

#   #   result =
#   #     case order_by_params do
#   #       [] -> result
#   #       res -> result |> Ecto.Query.order_by(^res)
#   #     end

#   #   result
#   #   |> Repo.paginate(page: page_number, page_size: page_size)
#   # end

#   def update(module, id, company_id, user_role, %{} = attrs) when is_binary(id) do
#     module
#     |> get(id, company_id, user_role, [])
#     |> case do
#       {:ok, struct} ->
#         struct
#         |> module.changeset(attrs)
#         |> Repo.update()

#       res ->
#         res
#     end
#   end

#   def update(module, arg, %{} = attrs) do
#     arg
#     |> module.changeset(attrs)
#     |> Repo.update()
#   end

#   def update!(module, arg, %{} = attrs) do
#     arg
#     |> module.changeset(attrs)
#     |> Repo.update!()
#   end

#   def insert_or_update(module, params, target) do
#     module
#     |> Repo.insert_all(params, on_conflict: :replace_all, conflict_target: target)
#   end

#   def insert_or_update(module, params) do
#     module
#     |> Repo.insert_all(params, on_conflict: :replace_all)
#   end

#   def insert_all(module, params, opts) do
#     module
#     |> Repo.insert_all(params, opts)
#   end

#   def count(%{} = module) do
#     module
#     |> Repo.aggregate(:count, :id)
#   end

#   def count(query) do
#     Repo.aggregate(query, :count, :id)
#   end

#   def delete(param, module)

#   def delete(id, module) when is_binary(id) do
#     module
#     |> get(id, [])
#     |> case do
#       {:ok, struct} -> delete(struct, module)
#       res -> res
#     end
#   end

#   def delete(struct, _module) do
#     struct
#     |> Repo.delete()
#   end

#   def delete_all(%{} = module) do
#     module
#     |> Repo.delete_all()
#   end

#   def delete_all(query) do
#     query |> Repo.delete_all()
#   end

#   def changeset(module) do
#     struct(module)
#     |> module.changeset(%{})
#   end

#   def changeset(module, %{} = struct) do
#     module.changeset(struct, %{})
#   end

#   def changeset(module, %{} = struct, %{} = params) do
#     module.changeset(struct, params)
#   end

#   # def event_publish(params, event_data, module) do
#   #   case params do
#   #     {:ok, schema} ->
#   #       module_name =
#   #         Module.split(module)
#   #         |> List.last()
#   #         |> String.downcase()

#   #       event_topic = String.to_atom("#{module_name}_created")

#   #       event = %EventBus.Model.Event{
#   #         id: schema.id,
#   #         topic: event_topic,
#   #         data: event_data_model(schema, event_data)
#   #       }

#   #       EventBus.notify(event)
#   #       {:ok, schema}

#   #     other ->
#   #       other
#   #   end
#   # end

#   # def prepare_trackable_users_query(entity_id, action) do
#   #   from(
#   #     v in Core.Schema.Version,
#   #     where: v.entity_id == ^entity_id and v.action == ^action,
#   #     order_by: [
#   #       desc: v.recorded_at
#   #     ],
#   #     limit: 1
#   #   )
#   # end

#   # def most_recent_version_action_query(schema, action) do
#   #   from(
#   #     v in Core.Schema.Version,
#   #     where: v.entity_schema == ^schema and v.action == ^action,
#   #     distinct: v.entity_id,
#   #     order_by: [
#   #       desc: v.recorded_at
#   #     ]
#   #   )
#   # end

#   # defp event_data_model(schema, []), do: schema
#   # defp event_data_model(schema, event_data), do: Map.take(schema, event_data)

#   defp select_function(schema_struct, _return_type, []) do
#     schema_struct
#   end

#   defp select_function(schema_struct, :map, select_block) when is_list(select_block) do
#     select(schema_struct, [schema], map(schema, ^select_block))
#   end

#   defp select_function(schema_struct, :struct, select_block) when is_list(select_block) do
#     select(schema_struct, [schema], struct(schema, ^select_block))
#   end

#   defp select_function(schema_struct, :tuple, select_block) when is_list(select_block) do
#     select(schema_struct, [schema], map(schema, ^select_block))
#   end
# end
