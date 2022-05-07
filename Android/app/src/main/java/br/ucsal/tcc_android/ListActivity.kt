package br.ucsal.tcc_android

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import org.json.JSONArray

class ListActivity : AppCompatActivity() {
//    private var mList = List(1000) { "item: $it" }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list)
        val mList = mutableListOf<ListData>()
        val jsonArray = JSONArray(loadJSONFromAssets("MOCK_DATA.json"))
        for (i in 0 until jsonArray.length()) {
            val data = ListData()
            val jsonObject = jsonArray.getJSONObject(i)
            data.first_name = jsonObject.getString("first_name")
            data.image_url = jsonObject.getString("image_url")
            mList.add(data)
        }

        findViewById<RecyclerView>(R.id.recycler_view).adapter = RVAdapter(mList)
    }

    private fun loadJSONFromAssets(fileName: String): String {
        return this.assets.open(fileName).bufferedReader().use { reader ->
            reader.readText()
        }
    }
}

class RVAdapter(private val dataSet: List<ListData>) :
    ListAdapter<String, RVAdapter.ViewHolder>(DiffCallback) {
    companion object DiffCallback : DiffUtil.ItemCallback<String>() {
        override fun areItemsTheSame(oldItem: String, newItem: String): Boolean {
            return oldItem === newItem
        }

        override fun areContentsTheSame(oldItem: String, newItem: String): Boolean {
            return oldItem == newItem
        }
    }

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val textView: TextView = view.findViewById(R.id.list_item_tv)
        val imageView: ImageView = view.findViewById(R.id.avatar)
    }

    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(viewGroup.context)
            .inflate(R.layout.list_item, viewGroup, false)

        return ViewHolder(view)
    }

    override fun onBindViewHolder(viewHolder: ViewHolder, position: Int) {
        val data = dataSet[position]
        viewHolder.textView.text = data.first_name
        viewHolder.imageView.apply {
            Glide.with(context)
                .load(data.image_url)
                .into(this)
        }
    }

    override fun getItemCount() = dataSet.size

}